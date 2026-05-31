import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
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
      'assets/images/perfil.png',
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

// ── ALTERADO: StatelessWidget → StatefulWidget para buscar saldo ──
class WalletCard extends StatefulWidget {
  const WalletCard({
    super.key,
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
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  double _saldo = 0;
  bool _carregando = true;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _ouvirSaldo();
  }

  void _ouvirSaldo() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => _carregando = false);
      return;
    }

    _subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('carteira')
        .doc('saldo')
        .snapshots()
        .listen((snap) {
          if (!mounted) return;
          setState(() {
            _saldo = (snap.data()?['saldo'] as num? ?? 0).toDouble();
            _carregando = false;
          });
        });
  }

    @override
  void dispose() {
    _subscription?.cancel(); // <-- cancela ao sair
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saldoTexto = _carregando
        ? 'Carregando...'
        : widget.showBalance
        ? 'R\$ ${_saldo.toStringAsFixed(2)}'
        : 'R\$ ******';

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
            color: widget.primaryPurple.withValues(alpha: 0.18),
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
                saldoTexto, // ── ALTERADO: era 'R\$ 1.922,34'
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
          const SizedBox(height: 20),
          Row(
            children: [
              _CardActionChip(
                label: 'Carteira',
                icon: CupertinoIcons.creditcard_fill,
                onTap: widget.onCardTap,
              ),
              const Spacer(),
              _TapTarget(
                onTap: widget.onMoreTap,
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

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.onRouteTap});

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

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key, required this.onRouteTap});

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
            icon: CupertinoIcons.house_fill,
            isActive: true,
            label: 'Home',
            onTap: () => onRouteTap(AppRoutes.mainRoute),
          ),
          _NavIcon(
            icon: CupertinoIcons.search,
            isActive: false,
            onTap: () => onRouteTap(AppRoutes.catalogo),
          ),
          _NavIcon(
            icon: CupertinoIcons.square_grid_2x2,
            isActive: false,
            onTap: () => onRouteTap(AppRoutes.balcao),
          ),
          _NavIcon(
            icon: CupertinoIcons.person_crop_circle,
            isActive: false,
            onTap: () => onRouteTap(AppRoutes.profileSecurity),
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
