// ── wallet_dashboard_screen.dart (Home Dashboard) ─────────────────────
// Tela principal (index 0 do MainWrapperScreen).
// SEM BottomNavigationBar (gerenciada pelo Wrapper global).
// SEM mocks de AppStorage/SharedPreferences.
// ──────────────────────────────────────────────────────────────────────
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/features/startups/data/startup_service.dart';
import 'package:mobile/features/startups/domain/startup.dart';
import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';

// ── Helpers ──────────────────────────────────────────────────────────
String? _normalizeUserName(String? value) {
  final t = value?.trim();
  return (t == null || t.isEmpty) ? null : t;
}

String? _nameFromEmail(String? email) {
  final raw = email?.split('@').first.trim();
  if (raw == null || raw.isEmpty) return null;
  return raw
      .replaceAll(RegExp(r'[._-]+'), ' ')
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .map((w) => w.length == 1
          ? w.toUpperCase()
          : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');
}

String _formatCents(int c) {
  final v = (c / 100).toStringAsFixed(2).replaceAll('.', ',');
  return 'R\$$v';
}

String _stageLabel(String s) => s.trim().isEmpty ? 'Sem status' : s;

List<StartupDetail> _featuredStartups(List<StartupDetail> list) {
  final f = list.where((s) => s.tags.any((t) {
        final n = t.toLowerCase().trim();
        return n == 'semana' || n == 'destaque' || n == 'featured' || n == 'week';
      })).toList();
  return f.isNotEmpty ? f : list.take(1).toList();
}

// ── Dados estáticos (substituir por Firebase futuramente) ────────────
const double _mockBalance = 1922.34;

// =====================================================================
// WIDGET PRINCIPAL
// =====================================================================
class WalletDashboardPage extends StatefulWidget {
  const WalletDashboardPage({super.key});
  @override
  State<WalletDashboardPage> createState() => _WalletDashboardPageState();
}

class _WalletDashboardPageState extends State<WalletDashboardPage> {
  final StartupService _startupService = StartupService();
  late Future<List<StartupDetail>> _startupsFuture;

  bool _showBalance = true;
  String _userName = 'Usuário';
  String? _userPhotoUrl;

  static const _bg = Color(0xFFF5F5F5);
  static const _purple = Color(0xFF5A2D91);
  static const _blue = Color(0xFF4169FF);
  static const _green = Color(0xFF18A71B);
  static const _card = Color(0xFFF7F7FA);

  @override
  void initState() {
    super.initState();
    _startupsFuture = _startupService.getStartups().timeout(
          const Duration(seconds: 10),
          onTimeout: () => const [],
        );
    unawaited(_loadFirebaseUser());
  }

  Future<void> _loadFirebaseUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final name = _normalizeUserName(user.displayName) ??
        _nameFromEmail(user.email) ??
        _normalizeUserName(user.email);
    if (!mounted) return;
    setState(() {
      _userName = name ?? _userName;
      _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
    });
  }

  void _toggle() => setState(() => _showBalance = !_showBalance);

  void _msg(String m) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text(m),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ));
  }

  // ── CORREÇÃO DE NAVEGAÇÃO VIA GLOBAL KEY ──────────────────────────
  void _push(String r) {
    final wrapper = AppRoutes.mainWrapperKey.currentState;
    
    // Se o Wrapper existir (estamos logados), trocamos de aba
    if (wrapper != null) {
      if (r == AppRoutes.investir || r == AppRoutes.vender || r == AppRoutes.balcao || r == AppRoutes.comprar) {
        wrapper.setIndex(2); // Aba do Balcão
        return;
      }
      if (r == AppRoutes.loja || r == AppRoutes.catalogo) {
        wrapper.setIndex(1); // Aba de Explorar
        return;
      }
      if (r == AppRoutes.perfil || r == AppRoutes.profileSecurity) {
        wrapper.setIndex(3); // Aba de Perfil
        return;
      }
    }
    
    // Fallback: Se for uma rota que não é aba (ex: Detalhes, Notificações), faz o push
    Navigator.of(context).pushNamed(r);
  }
  // ──────────────────────────────────────────────────────────────────

  void _openDetail(StartupDetail s) => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => StartupDetailScreen(startup: s)),
      );

  void _reload() {
    setState(() {
      _startupsFuture = _startupService.getStartups().timeout(
            const Duration(seconds: 10),
            onTimeout: () => const [],
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(
                  purple: _purple,
                  userName: _userName,
                  photoUrl: _userPhotoUrl,
                  showBalance: _showBalance,
                  onToggle: _toggle,
                  onBell: () => _push(AppRoutes.notificacoes),
                ),
                const SizedBox(height: 24),
                _WalletCard(
                  purple: _purple,
                  show: _showBalance,
                  onCard: () => _push(AppRoutes.cartao),
                  onMore: () => _msg('Opções da carteira'),
                ),
                const SizedBox(height: 26),
                _QuickActions(onRoute: _push),
                const SizedBox(height: 24),
                _StartupSections(
                  future: _startupsFuture,
                  bg: _card,
                  blue: _blue,
                  green: _green,
                  onRetry: _reload,
                  onAll: () => _push(AppRoutes.loja),
                  onTap: _openDetail,
                  onMore: () => _msg('Opções dos investimentos'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// HEADER (Inalterado)
// =====================================================================
class _Header extends StatelessWidget {
  const _Header({
    required this.purple, required this.userName, required this.photoUrl,
    required this.showBalance, required this.onToggle, required this.onBell,
  });
  final Color purple;
  final String userName;
  final String? photoUrl;
  final bool showBalance;
  final VoidCallback onToggle, onBell;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: ClipOval(child: _Avatar(url: photoUrl)),
      ),
      const SizedBox(width: 12),
      Flexible(child: Text('Olá, $userName', maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: purple, fontSize: 17, fontWeight: FontWeight.w600))),
      const Spacer(),
      _Tap(onTap: onToggle, child: Icon(showBalance ? CupertinoIcons.eye_slash : CupertinoIcons.eye, color: purple, size: 23)),
      const SizedBox(width: 14),
      _Tap(onTap: onBell, child: Icon(CupertinoIcons.bell, color: purple, size: 22)),
    ]);
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    final s = url?.trim();
    if (s != null && s.isNotEmpty) {
      return s.startsWith('http')
          ? Image.network(s, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const _DefAvatar())
          : Image.asset(s, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const _DefAvatar());
    }
    return Image.asset('assets/images/perfil.png', fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _DefAvatar());
  }
}

class _DefAvatar extends StatelessWidget {
  const _DefAvatar();
  @override
  Widget build(BuildContext context) => const DecoratedBox(
        decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0xFF5A2D91), Color(0xFF9B8BAF)])),
        child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: 23));
}

// =====================================================================
// WALLET CARD (Inalterado)
// =====================================================================
class _WalletCard extends StatelessWidget {
  const _WalletCard({required this.purple, required this.show, required this.onCard, required this.onMore});
  final Color purple;
  final bool show;
  final VoidCallback onCard, onMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF6B33B4), Color(0xFF5B2E92), Color(0xFF44206F)]),
        boxShadow: [BoxShadow(color: purple.withOpacity(0.18), blurRadius: 22, offset: const Offset(0, 12))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Expanded(child: Text('MesclaInvest', style: TextStyle(color: Colors.white, fontFamily: 'Georgia', fontSize: 16, fontWeight: FontWeight.w500))),
          Text(show ? 'R\$ 1.922,34' : 'R\$ ******', style: const TextStyle(color: Colors.white, fontFamily: 'Georgia', fontSize: 18, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 9),
        const Row(children: [
          Icon(CupertinoIcons.building_2_fill, color: Colors.white70, size: 12),
          SizedBox(width: 6),
          Text('05 23-12 - 856988490', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          _Chip(label: 'Carteira', icon: CupertinoIcons.creditcard_fill, onTap: onCard),
          const Spacer(),
          _Tap(onTap: onMore, child: Container(width: 24, height: 24,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), shape: BoxShape.circle),
              alignment: Alignment.center, child: const Icon(CupertinoIcons.ellipsis, color: Colors.white, size: 14))),
        ]),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16),
        child: Container(height: 30, padding: const EdgeInsets.symmetric(horizontal: 9),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.26), borderRadius: BorderRadius.circular(16)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, color: Colors.white, size: 14), const SizedBox(width: 5),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w500)),
            ]))));
  }
}

class _Tap extends StatelessWidget {
  const _Tap({required this.onTap, required this.child});
  final VoidCallback onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) => Material(color: Colors.transparent,
      child: InkResponse(onTap: onTap, radius: 24, child: Padding(padding: const EdgeInsets.all(4), child: child)));
}

// =====================================================================
// QUICK ACTIONS (Inalterado)
// =====================================================================
class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onRoute});
  final ValueChanged<String> onRoute;
  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFEFEFF2);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _QBtn(label: 'Investir', bg: bg, icon: Icons.insert_chart_outlined_rounded, onTap: () => onRoute(AppRoutes.investir)),
      _QBtn(label: 'Vender', bg: bg, icon: CupertinoIcons.money_dollar_circle, onTap: () => onRoute(AppRoutes.vender)),
      _QBtn(label: 'Depositar', bg: bg, icon: CupertinoIcons.arrow_up, onTap: () => onRoute(AppRoutes.depositar)),
      _QBtn(label: 'Sacar', bg: bg, icon: CupertinoIcons.arrow_down, onTap: () => onRoute(AppRoutes.sacar)),
    ]);
  }
}

class _QBtn extends StatelessWidget {
  const _QBtn({required this.label, required this.icon, required this.bg, required this.onTap});
  final String label;
  final IconData icon;
  final Color bg;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(32),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), child: Column(children: [
          Container(width: 46, height: 46, decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              alignment: Alignment.center, child: Icon(icon, color: Colors.black87, size: 23)),
          const SizedBox(height: 9),
          Text(label, style: const TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500)),
        ]))));
  }
}

// =====================================================================
// INVESTMENT SECTIONS (FIRESTORE) (Inalterado)
// =====================================================================
class _StartupSections extends StatelessWidget {
  const _StartupSections({
    required this.future, required this.bg, required this.blue,
    required this.green, required this.onRetry, required this.onAll,
    required this.onTap, required this.onMore,
  });
  final Future<List<StartupDetail>> future;
  final Color bg, blue, green;
  final VoidCallback onRetry, onAll, onMore;
  final ValueChanged<StartupDetail> onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StartupDetail>>(
      future: future,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _Sections(bg: bg, blue: blue, green: green, inv: const [], wk: const [],
              invMsg: 'Carregando empresas do Firestore...', wkMsg: 'Carregando empresas da semana...',
              onAll: onAll, onMore: onMore);
        }
        if (snap.hasError) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _Sections(bg: bg, blue: blue, green: green, inv: const [], wk: const [],
                invMsg: 'Não foi possível carregar as empresas.',
                wkMsg: 'Configure o Firebase ou tente novamente.', onAll: onAll, onMore: onMore),
            const SizedBox(height: 10),
            Align(alignment: Alignment.centerLeft, child: TextButton.icon(
                onPressed: onRetry, icon: const Icon(Icons.refresh, size: 18), label: const Text('Tentar novamente'))),
          ]);
        }
        final all = snap.data ?? [];
        final inv = all.take(3).map(_Item.fromStartup).toList();
        final wk = _featuredStartups(all).take(3).map(_Item.fromStartup).toList();
        return _Sections(bg: bg, blue: blue, green: green, inv: inv, wk: wk,
            invMsg: 'Nenhuma empresa cadastrada.', wkMsg: 'Nenhuma empresa da semana.',
            onAll: onAll, onMore: onMore, onItemTap: (i) { if (i.startup != null) onTap(i.startup!); });
      },
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({
    required this.bg, required this.blue, required this.green,
    required this.inv, required this.wk, required this.invMsg,
    required this.wkMsg, required this.onAll, required this.onMore, this.onItemTap,
  });
  final Color bg, blue, green;
  final List<_Item> inv, wk;
  final String invMsg, wkMsg;
  final VoidCallback onAll, onMore;
  final ValueChanged<_Item>? onItemTap;

  @override
  Widget build(BuildContext context) => Column(children: [
        _Section(title: 'Seus Investimentos', bg: bg, blue: blue, green: green,
            items: inv, empty: invMsg, showMore: true, showAll: inv.isNotEmpty,
            onMore: onMore, onAll: onAll, onItemTap: onItemTap),
        const SizedBox(height: 22),
        _Section(title: 'Empresas da Semana', bg: bg, blue: blue, green: green,
            items: wk, empty: wkMsg, onItemTap: onItemTap),
      ]);
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title, required this.items, required this.bg,
    required this.blue, required this.green, this.showMore = false,
    this.showAll = false, this.empty = '', this.onMore, this.onAll, this.onItemTap,
  });
  final String title, empty;
  final List<_Item> items;
  final Color bg, blue, green;
  final bool showMore, showAll;
  final VoidCallback? onMore, onAll;
  final ValueChanged<_Item>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 6))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF191919), fontFamily: 'Georgia', fontSize: 16, fontWeight: FontWeight.w500))),
          if (showMore) _Tap(onTap: onMore ?? () {}, child: const Icon(CupertinoIcons.ellipsis, size: 18, color: Color(0xFF1D1D1F))),
        ]),
        const SizedBox(height: 12),
        if (items.isEmpty) _Empty(msg: empty)
        else for (var i = 0; i < items.length; i++) ...[
          _Tile(item: items[i], blue: blue, green: green,
              onTap: onItemTap == null ? null : () => onItemTap!(items[i])),
          if (i != items.length - 1) const Divider(height: 18, thickness: 0.7, color: Color(0xFFD3D4D8)),
        ],
        if (showAll) ...[
          const SizedBox(height: 14),
          InkWell(onTap: onAll, borderRadius: BorderRadius.circular(8),
              child: const Padding(padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('Ver Todos', style: TextStyle(color: Color(0xFF4169FF), fontSize: 14, fontWeight: FontWeight.w500)))),
        ],
      ]),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Row(children: [
        Container(width: 36, height: 36, decoration: const BoxDecoration(color: Color(0xFFEDEDF1), shape: BoxShape.circle),
            child: const Icon(CupertinoIcons.building_2_fill, color: Color(0xFF777777), size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Text(msg, style: const TextStyle(color: Color(0xFF6F6F76), fontSize: 13, height: 1.3))),
      ]));
}

class _Tile extends StatelessWidget {
  const _Tile({required this.item, required this.blue, required this.green, this.onTap});
  final _Item item;
  final Color blue, green;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Row(children: [
          SizedBox(width: 38, child: _Logo(url: item.imageUrl, label: item.company)),
          const SizedBox(width: 10),
          Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.company, overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF191919), fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text(item.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF6F6F76), fontSize: 12)),
          ])),
          Expanded(flex: 2, child: Text(item.status, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: blue, fontSize: 13, fontWeight: FontWeight.w500))),
          const SizedBox(width: 8),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(item.value, style: const TextStyle(color: Color(0xFF1D1D1F), fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(width: 8),
            const Icon(CupertinoIcons.chevron_forward, size: 12, color: Color(0xFF1D1D1F)),
          ]),
        ]))));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({this.url, required this.label});
  final String? url;
  final String label;
  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty) {
      final img = url!.startsWith('http')
          ? Image.network(url!, fit: BoxFit.contain, errorBuilder: (_, __, ___) => _Fallback(l: label))
          : Image.asset(url!, fit: BoxFit.contain, errorBuilder: (_, __, ___) => _Fallback(l: label));
      return ClipRRect(borderRadius: BorderRadius.circular(8), child: SizedBox(width: 32, height: 32, child: img));
    }
    return _Fallback(l: label);
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.l});
  final String l;
  @override
  Widget build(BuildContext context) {
    final i = l.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).take(2).map((p) => p[0].toUpperCase()).join();
    return Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFFEDEDF1), borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center, child: Text(i.isEmpty ? '?' : i, style: const TextStyle(color: Color(0xFF1D1D1F), fontSize: 13, fontWeight: FontWeight.w700)));
  }
}

// ── Data class para itens da lista ──────────────────────────────────
class _Item {
  const _Item({required this.company, required this.subtitle, required this.status, required this.value, this.imageUrl, this.startup});
  factory _Item.fromStartup(StartupDetail s) => _Item(
        company: s.name,
        subtitle: s.shortDescription,
        status: _stageLabel(s.stage),
        value: _formatCents(s.currentTokenPriceCents),
        imageUrl: s.coverImageUrl,
        startup: s,
      );
  final String company, subtitle, status, value;
  final String? imageUrl;
  final StartupDetail? startup;
}
