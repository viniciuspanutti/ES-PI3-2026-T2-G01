import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/startups/data/startup_service.dart';
import 'package:mobile/features/startups/domain/startup.dart';

class FirestoreInvestmentSections extends StatelessWidget {
  const FirestoreInvestmentSections({
    super.key,
    required this.userId,
    required this.backgroundColor,
    required this.statusColor,
    required this.growthColor,
    required this.onRetry,
    required this.onViewAllTap,
    required this.onStartupTap,
    required this.onMoreTap,
  });

  final String? userId;
  final Color backgroundColor;
  final Color statusColor;
  final Color growthColor;
  final VoidCallback onRetry;
  final VoidCallback onViewAllTap;
  final ValueChanged<StartupDetail> onStartupTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return _buildSection(
        investments: const [],
        message: 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. '
            'Explore o cat\u00e1logo!',
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('investimentos')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSection(
            investments: const [],
            message: 'Carregando investimentos...',
          );
        }

        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSection(
                investments: const [],
                message: 'N\u00e3o foi poss\u00edvel carregar seus investimentos.',
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Tentar novamente'),
                ),
              ),
            ],
          );
        }

        final docs = snapshot.data?.docs ?? [];
        final investedIds = docs
            .where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return (data['tokensComprados'] ?? 0) > 0;
            })
            .map((doc) => doc.id)
            .toList();

        if (investedIds.isEmpty) {
          return _buildSection(
            investments: const [],
            message: 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. '
                'Explore o cat\u00e1logo!',
          );
        }

        return FutureBuilder<List<StartupDetail>>(
          future: _fetchInvestedStartups(investedIds),
          builder: (context, startupSnap) {
            if (startupSnap.connectionState == ConnectionState.waiting) {
              return _buildSection(
                investments: const [],
                message: 'Carregando detalhes dos investimentos...',
              );
            }

            final startups = startupSnap.data ?? [];
            final investments = startups
                .take(3)
                .map(_InvestmentItemData.fromStartup)
                .toList(growable: false);

            return _buildSection(
              investments: investments,
              message: 'Nenhum investimento encontrado.',
            );
          },
        );
      },
    );
  }

  Widget _buildSection({
    required List<_InvestmentItemData> investments,
    required String message,
  }) {
    return _InvestmentSection(
      title: 'Seus Investimentos',
      backgroundColor: backgroundColor,
      statusColor: statusColor,
      growthColor: growthColor,
      showMoreButton: true,
      showViewAll: investments.isNotEmpty,
      emptyMessage: message,
      onMoreTap: onMoreTap,
      onViewAllTap: onViewAllTap,
      onItemTap: (item) {
        final startup = item.startup;
        if (startup != null) onStartupTap(startup);
      },
      items: investments,
    );
  }
}

Future<List<StartupDetail>> _fetchInvestedStartups(
  List<String> startupIds,
) async {
  final service = StartupService();
  final List<StartupDetail> result = [];
  for (final id in startupIds) {
    try {
      result.add(await service.getStartupDetails(id));
    } catch (_) {
      // Startup n\u00e3o encontrada no cat\u00e1logo, ignora
    }
  }
  return result;
}



class _SectionTapTarget extends StatelessWidget {
  const _SectionTapTarget({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: 22,
        child: SizedBox(width: 34, height: 34, child: Center(child: child)),
      ),
    );
  }
}

class _InvestmentSection extends StatelessWidget {
  const _InvestmentSection({
    required this.title,
    required this.items,
    required this.backgroundColor,
    required this.statusColor,
    required this.growthColor,
    this.showMoreButton = false,
    this.showViewAll = false,
    this.emptyMessage = 'Nenhuma empresa encontrada.',
    this.onMoreTap,
    this.onViewAllTap,
    this.onItemTap,
  });

  final String title;
  final List<_InvestmentItemData> items;
  final Color backgroundColor;
  final Color statusColor;
  final Color growthColor;
  final bool showMoreButton;
  final bool showViewAll;
  final String emptyMessage;
  final VoidCallback? onMoreTap;
  final VoidCallback? onViewAllTap;
  final ValueChanged<_InvestmentItemData>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF191919),
                    fontFamily: 'Georgia',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (showMoreButton)
                _SectionTapTarget(
                  onTap: onMoreTap ?? () {},
                  child: const Icon(
                    CupertinoIcons.ellipsis,
                    size: 18,
                    color: Color(0xFF1D1D1F),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            _SectionEmptyState(message: emptyMessage)
          else
            for (var index = 0; index < items.length; index++) ...[
              _InvestmentListTile(
                item: items[index],
                statusColor: statusColor,
                growthColor: growthColor,
                onTap: onItemTap == null
                    ? null
                    : () => onItemTap!(items[index]),
              ),
              if (index != items.length - 1)
                const Divider(
                  height: 18,
                  thickness: 0.7,
                  color: Color(0xFFD3D4D8),
                ),
            ],
          if (showViewAll) ...[
            const SizedBox(height: 14),
            InkWell(
              onTap: onViewAllTap,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Ver Todos',
                  style: TextStyle(
                    color: Color(0xFF4169FF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionEmptyState extends StatelessWidget {
  const _SectionEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFEDEDF1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.building_2_fill,
              color: Color(0xFF777777),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF6F6F76),
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InvestmentListTile extends StatelessWidget {
  const _InvestmentListTile({
    required this.item,
    required this.statusColor,
    required this.growthColor,
    this.onTap,
  });

  final _InvestmentItemData item;
  final Color statusColor;
  final Color growthColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              SizedBox(
                width: 38,
                child: _CompanyLogo(
                  imageUrl: item.imageUrl,
                  fallbackLabel: item.company,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.company,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF191919),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (item.variation.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.variation,
                            style: TextStyle(
                              color: growthColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.arrow_drop_up,
                            color: growthColor,
                            size: 14,
                          ),
                        ],
                      )
                    else if (item.subtitle.isNotEmpty)
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF6F6F76),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  item.status,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: Color(0xFF1D1D1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.chevron_forward,
                    size: 12,
                    color: Color(0xFF1D1D1F),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({required this.imageUrl, required this.fallbackLabel});

  final String? imageUrl;
  final String fallbackLabel;

  @override
  Widget build(BuildContext context) {
    final logo = imageUrl;

    if (logo != null && logo.isNotEmpty) {
      final image = logo.startsWith('http')
          ? Image.network(
              logo,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => _LogoFallback(label: fallbackLabel),
            )
          : Image.asset(
              logo,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => _LogoFallback(label: fallbackLabel),
            );

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(width: 32, height: 32, child: image),
      );
    }

    return _LogoFallback(label: fallbackLabel);
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final initials = label
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDF1),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: const TextStyle(
          color: Color(0xFF1D1D1F),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}



String _formatCurrencyCents(int cents) {
  final value = (cents / 100).toStringAsFixed(2).replaceAll('.', ',');
  return 'R\$$value';
}

String _formatPercent(double value) {
  return '${value.toStringAsFixed(2).replaceAll('.', ',')}%';
}

String _stageLabel(String stage) {
  if (stage.trim().isEmpty) return 'Sem status';
  return stage;
}

class _InvestmentItemData {
  const _InvestmentItemData({
    required this.company,
    required this.subtitle,
    required this.variation,
    required this.status,
    required this.value,
    this.imageUrl,
    this.startup,
  });

  factory _InvestmentItemData.fromStartup(StartupDetail startup) {
    final valueCents =
        startup.investmentValueCents ?? startup.currentTokenPriceCents;

    return _InvestmentItemData(
      company: startup.name,
      subtitle: startup.shortDescription,
      variation: startup.weeklyVariationPercent == null
          ? ''
          : _formatPercent(startup.weeklyVariationPercent!),
      status: _stageLabel(startup.stage),
      value: _formatCurrencyCents(valueCents),
      imageUrl: startup.coverImageUrl,
      startup: startup,
    );
  }

  final String company;
  final String subtitle;
  final String variation;
  final String status;
  final String value;
  final String? imageUrl;
  final StartupDetail? startup;
}
