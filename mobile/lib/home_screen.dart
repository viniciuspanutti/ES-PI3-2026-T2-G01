import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/features/startups/data/startup_service.dart';
import 'package:mobile/features/startups/domain/startup.dart';
import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';

Future<bool> _initializeFirebaseIfConfigured() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    return Firebase.apps.isNotEmpty;
  } catch (_) {
    return false;
  }
}

String? _firstString(Map<dynamic, dynamic> values, List<String> keys) {
  for (final key in keys) {
    final value = values[key];
    if (value is String && value.trim().isNotEmpty) return value.trim();
  }
  return null;
}

String? _normalizeUserName(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed;
}

String? _nameFromEmail(String? email) {
  final rawName = email?.split('@').first.trim();
  if (rawName == null || rawName.isEmpty) return null;

  return rawName
      .replaceAll(RegExp(r'[._-]+'), ' ')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .map((word) {
        if (word.length == 1) return word.toUpperCase();
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      })
      .join(' ');
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StartupService _startupService = StartupService();
  late Future<List<StartupDetail>> _startupsFuture;

  bool _showBalance = true;
  bool _didReadRouteUser = false;
  String _userName = 'Usu\u00e1rio';
  String? _userPhotoUrl;

  static const _screenBackground = Color(0xFFF5F5F5);
  static const _primaryPurple = Color(0xFF5A2D91);
  static const _statusBlue = Color(0xFF4169FF);
  static const _positiveGreen = Color(0xFF18A71B);
  static const _softCard = Color(0xFFF7F7FA);

  @override
  void initState() {
    super.initState();
    _startupsFuture = _loadStartups();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didReadRouteUser) return;

    _didReadRouteUser = true;
    _applyRouteUserData(ModalRoute.of(context)?.settings.arguments);
    unawaited(_loadFirebaseUserData());
  }

  void _toggleBalanceVisibility() {
    setState(() => _showBalance = !_showBalance);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  void _openRoute(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _openStartupDetails(StartupDetail startup) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StartupDetailScreen(startup: startup),
      ),
    );
  }

  void _reloadStartups() {
    setState(() => _startupsFuture = _loadStartups());
  }

  void _applyRouteUserData(Object? arguments) {
    if (arguments is! Map) return;

    final name = _firstString(arguments, const [
      'name',
      'displayName',
      'userName',
      'nome',
    ]);
    final photoUrl = _firstString(arguments, const [
      'photoUrl',
      'photoURL',
      'avatarUrl',
      'profilePhotoUrl',
      'foto',
    ]);

    if (name == null && photoUrl == null) return;
    _userName = _normalizeUserName(name) ?? _userName;
    _userPhotoUrl = photoUrl ?? _userPhotoUrl;
  }

  Future<void> _loadFirebaseUserData() async {
    final initialized = await _initializeFirebaseIfConfigured().timeout(
      const Duration(seconds: 6),
      onTimeout: () => false,
    );
    if (!initialized) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final resolvedName =
        _normalizeUserName(user.displayName) ??
        _nameFromEmail(user.email) ??
        _normalizeUserName(user.email);

    if (!mounted) return;
    setState(() {
      _userName = resolvedName ?? _userName;
      _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
    });
  }

  Future<List<StartupDetail>> _loadStartups() async {
    final initialized = await _initializeFirebaseIfConfigured().timeout(
      const Duration(seconds: 6),
      onTimeout: () => false,
    );
    if (!initialized) return const [];

    return _startupService.getStartups().timeout(
      const Duration(seconds: 10),
      onTimeout: () => const [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: _screenBackground,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth < 390
                  ? constraints.maxWidth
                  : 390.0;

              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: screenWidth,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 116),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _Header(
                                primaryPurple: _primaryPurple,
                                userName: _userName,
                                userPhotoUrl: _userPhotoUrl,
                                showBalance: _showBalance,
                                onToggleVisibility: _toggleBalanceVisibility,
                                onNotificationsTap: () =>
                                    _openRoute(AppRoutes.notificacoes),
                              ),
                              const SizedBox(height: 24),
                              _WalletCard(
                                primaryPurple: _primaryPurple,
                                showBalance: _showBalance,
                                onCardTap: () => _openRoute(AppRoutes.cartao),
                                onMoreTap: () => _showMessage(
                                  'Op\u00e7\u00f5es da carteira',
                                ),
                              ),
                              const SizedBox(height: 26),
                              _QuickActions(onRouteTap: _openRoute),
                              const SizedBox(height: 24),
                              _FirestoreInvestmentSections(
                                startupsFuture: _startupsFuture,
                                backgroundColor: _softCard,
                                statusColor: _statusBlue,
                                growthColor: _positiveGreen,
                                onRetry: _reloadStartups,
                                onViewAllTap: () => _openRoute(AppRoutes.loja),
                                onStartupTap: _openStartupDetails,
                                onMoreTap: () => _showMessage(
                                  'Op\u00e7\u00f5es dos investimentos',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        right: 18,
                        bottom: 14,
                        child: _BottomNavigationBar(
                          onRouteTap: (routeName) {
                            if (routeName == AppRoutes.home ||
                                routeName == AppRoutes.menu) {
                              _showMessage(
                                'Voc\u00ea j\u00e1 est\u00e1 no Menu',
                              );
                              return;
                            }
                            _openRoute(routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.primaryPurple,
    required this.userName,
    required this.userPhotoUrl,
    required this.showBalance,
    required this.onToggleVisibility,
    required this.onNotificationsTap,
  });

  final Color primaryPurple;
  final String userName;
  final String? userPhotoUrl;
  final bool showBalance;
  final VoidCallback onToggleVisibility;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(child: _ProfileAvatar(photoUrl: userPhotoUrl)),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            'Ol\u00e1, $userName',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: primaryPurple,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Spacer(),
        _TapTarget(
          onTap: onToggleVisibility,
          child: Icon(
            showBalance ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            color: primaryPurple,
            size: 23,
          ),
        ),
        const SizedBox(width: 14),
        _TapTarget(
          onTap: onNotificationsTap,
          child: Icon(CupertinoIcons.bell, color: primaryPurple, size: 22),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final source = photoUrl?.trim();

    if (source != null && source.isNotEmpty) {
      if (source.startsWith('http')) {
        return Image.network(
          source,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
        );
      }

      return Image.asset(
        source,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
      );
    }

    return Image.asset(
      'lib/features/home/images/perfil.png',
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
    );
  }
}

class _DefaultProfileAvatar extends StatelessWidget {
  const _DefaultProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF5A2D91), Color(0xFF9B8BAF)],
        ),
      ),
      child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: 23),
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard({
    required this.primaryPurple,
    required this.showBalance,
    required this.onCardTap,
    required this.onMoreTap,
  });

  final Color primaryPurple;
  final bool showBalance;
  final VoidCallback onCardTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6B33B4), Color(0xFF5B2E92), Color(0xFF44206F)],
        ),
        boxShadow: [
          BoxShadow(
            color: primaryPurple.withValues(alpha: 0.18),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'MesclaInvest',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Georgia',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                showBalance ? 'R\$ 1.922,34' : 'R\$ ******',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Row(
            children: [
              Icon(
                CupertinoIcons.building_2_fill,
                color: Colors.white70,
                size: 12,
              ),
              SizedBox(width: 6),
              Text(
                '05 23-12 - 856988490',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _CardActionChip(
                label: 'Carteira',
                icon: CupertinoIcons.creditcard_fill,
                onTap: onCardTap,
              ),
              const Spacer(),
              _TapTarget(
                onTap: onMoreTap,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    CupertinoIcons.ellipsis,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardActionChip extends StatelessWidget {
  const _CardActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.26),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 14),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TapTarget extends StatelessWidget {
  const _TapTarget({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: Padding(padding: const EdgeInsets.all(4), child: child),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onRouteTap});

  final ValueChanged<String> onRouteTap;

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFEFEFF2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _QuickActionButton(
          label: 'Investir',
          backgroundColor: background,
          icon: Icons.insert_chart_outlined_rounded,
          onTap: () => onRouteTap(AppRoutes.investir),
        ),
        _QuickActionButton(
          label: 'Vender',
          backgroundColor: background,
          icon: CupertinoIcons.money_dollar_circle,
          onTap: () => onRouteTap(AppRoutes.vender),
        ),
        _QuickActionButton(
          label: 'Depositar',
          backgroundColor: background,
          icon: CupertinoIcons.arrow_up,
          onTap: () => onRouteTap(AppRoutes.depositar),
        ),
        _QuickActionButton(
          label: 'Sacar',
          backgroundColor: background,
          icon: CupertinoIcons.arrow_down,
          onTap: () => onRouteTap(AppRoutes.sacar),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Column(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: Colors.black87, size: 23),
              ),
              const SizedBox(height: 9),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirestoreInvestmentSections extends StatelessWidget {
  const _FirestoreInvestmentSections({
    required this.startupsFuture,
    required this.backgroundColor,
    required this.statusColor,
    required this.growthColor,
    required this.onRetry,
    required this.onViewAllTap,
    required this.onStartupTap,
    required this.onMoreTap,
  });

  final Future<List<StartupDetail>> startupsFuture;
  final Color backgroundColor;
  final Color statusColor;
  final Color growthColor;
  final VoidCallback onRetry;
  final VoidCallback onViewAllTap;
  final ValueChanged<StartupDetail> onStartupTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StartupDetail>>(
      future: startupsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _InvestmentSectionsBody(
            backgroundColor: backgroundColor,
            statusColor: statusColor,
            growthColor: growthColor,
            investments: const [],
            weeklyCompanies: const [],
            investmentsMessage: 'Carregando empresas do Firestore...',
            weeklyMessage: 'Carregando empresas da semana...',
            onViewAllTap: onViewAllTap,
            onMoreTap: onMoreTap,
          );
        }

        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _InvestmentSectionsBody(
                backgroundColor: backgroundColor,
                statusColor: statusColor,
                growthColor: growthColor,
                investments: const [],
                weeklyCompanies: const [],
                investmentsMessage:
                    'N\u00e3o foi poss\u00edvel carregar as empresas.',
                weeklyMessage:
                    'Configure o Firebase ou tente novamente em instantes.',
                onViewAllTap: onViewAllTap,
                onMoreTap: onMoreTap,
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

        final startups = snapshot.data ?? [];
        final investments = startups
            .take(3)
            .map(_InvestmentItemData.fromStartup)
            .toList(growable: false);
        final weeklyCompanies = _featuredStartups(
          startups,
        ).take(3).map(_InvestmentItemData.fromStartup).toList(growable: false);

        return _InvestmentSectionsBody(
          backgroundColor: backgroundColor,
          statusColor: statusColor,
          growthColor: growthColor,
          investments: investments,
          weeklyCompanies: weeklyCompanies,
          investmentsMessage: 'Nenhuma empresa cadastrada.',
          weeklyMessage: 'Nenhuma empresa da semana cadastrada.',
          onViewAllTap: onViewAllTap,
          onMoreTap: onMoreTap,
          onItemTap: (item) {
            final startup = item.startup;
            if (startup != null) onStartupTap(startup);
          },
        );
      },
    );
  }
}

class _InvestmentSectionsBody extends StatelessWidget {
  const _InvestmentSectionsBody({
    required this.backgroundColor,
    required this.statusColor,
    required this.growthColor,
    required this.investments,
    required this.weeklyCompanies,
    required this.investmentsMessage,
    required this.weeklyMessage,
    required this.onViewAllTap,
    required this.onMoreTap,
    this.onItemTap,
  });

  final Color backgroundColor;
  final Color statusColor;
  final Color growthColor;
  final List<_InvestmentItemData> investments;
  final List<_InvestmentItemData> weeklyCompanies;
  final String investmentsMessage;
  final String weeklyMessage;
  final VoidCallback onViewAllTap;
  final VoidCallback onMoreTap;
  final ValueChanged<_InvestmentItemData>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InvestmentSection(
          title: 'Seus Investimentos',
          backgroundColor: backgroundColor,
          statusColor: statusColor,
          growthColor: growthColor,
          showMoreButton: true,
          showViewAll: investments.isNotEmpty,
          emptyMessage: investmentsMessage,
          onMoreTap: onMoreTap,
          onViewAllTap: onViewAllTap,
          onItemTap: onItemTap,
          items: investments,
        ),
        const SizedBox(height: 22),
        _InvestmentSection(
          title: 'Empresas da Semana',
          backgroundColor: backgroundColor,
          statusColor: statusColor,
          growthColor: growthColor,
          emptyMessage: weeklyMessage,
          onItemTap: onItemTap,
          items: weeklyCompanies,
        ),
      ],
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
                _TapTarget(
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

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({required this.onRouteTap});

  final ValueChanged<String> onRouteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2F),
        borderRadius: BorderRadius.circular(38),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavIcon(
            icon: CupertinoIcons.creditcard,
            isActive: false,
            onTap: () => onRouteTap(AppRoutes.carteira),
          ),
          _NavIcon(
            icon: CupertinoIcons.bag,
            isActive: false,
            onTap: () => onRouteTap(AppRoutes.loja),
          ),
          _NavIcon(
            icon: CupertinoIcons.house_fill,
            isActive: true,
            label: 'Menu',
            onTap: () => onRouteTap(AppRoutes.home),
          ),
          _NavIcon(
            icon: CupertinoIcons.person_crop_circle,
            isActive: false,
            onTap: () => onRouteTap(AppRoutes.perfil),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.label,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final String? label;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF6B33B4),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 7),
                Text(
                  label ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: SizedBox(
          width: 42,
          child: Center(child: Icon(icon, color: Colors.white, size: 22)),
        ),
      ),
    );
  }
}

List<StartupDetail> _featuredStartups(List<StartupDetail> startups) {
  final featured = startups
      .where((startup) {
        if (startup.featuredThisWeek) return true;
        return startup.tags.any((tag) {
          final normalized = tag.toLowerCase().trim();
          return normalized == 'semana' ||
              normalized == 'destaque' ||
              normalized == 'featured' ||
              normalized == 'week';
        });
      })
      .toList(growable: false);

  if (featured.isNotEmpty) return featured;
  return startups.take(1).toList(growable: false);
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
