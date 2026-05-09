import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart';
import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart';
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

class WalletDashboardScreen extends StatefulWidget {
  const WalletDashboardScreen({super.key});

  @override
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
}

class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
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
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HomeHeader(
                          primaryPurple: _primaryPurple,
                          userName: _userName,
                          userPhotoUrl: _userPhotoUrl,
                          showBalance: _showBalance,
                          onToggleVisibility: _toggleBalanceVisibility,
                          onNotificationsTap: () =>
                              _openRoute(AppRoutes.notificacoes),
                        ),
                        const SizedBox(height: 24),
                        WalletCard(
                          primaryPurple: _primaryPurple,
                          showBalance: _showBalance,
                          onCardTap: () => _openRoute(AppRoutes.carteira),
                          onMoreTap: () => _showMessage(
                            'Op\u00e7\u00f5es da carteira',
                          ),
                        ),
                        const SizedBox(height: 26),
                        QuickActions(onRouteTap: _openRoute),
                        const SizedBox(height: 24),
                        FirestoreInvestmentSections(
                          startupsFuture: _startupsFuture,
                          backgroundColor: _softCard,
                          statusColor: _statusBlue,
                          growthColor: _positiveGreen,
                          onRetry: _reloadStartups,
                          onViewAllTap: () =>
                              _openRoute(AppRoutes.catalogo),
                          onStartupTap: _openStartupDetails,
                          onMoreTap: () => _showMessage(
                            'Op\u00e7\u00f5es dos investimentos',
                          ),
                        ),
                      ],
                    ),
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
