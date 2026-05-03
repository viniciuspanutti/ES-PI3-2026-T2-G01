import 'package:flutter/material.dart';
import 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
import 'package:mobile/features/wallet/presentation/trading_market_screen.dart';
import 'package:mobile/features/profile/presentation/security_settings_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => MainWrapperScreenState();
}

class MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;

  void setIndex(int index) {
    if (!mounted) return;
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [
    const WalletDashboardPage(),
    const CatalogoStartupsPage(),
    const BalcaoNegociacaoPage(),
    const ProfileSecurityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // BLINDAGEM: Intercepta o botão de voltar do hardware
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setIndex(0); // Se não estiver na home, volta pra home
          return false; // Bloqueia o fechamento do app
        }
        return true; // Se já estiver na home, permite o comportamento padrão
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF222222),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home_outlined, "Home", 0),
              _buildNavItem(Icons.search, "Explorar", 1),
              _buildNavItem(Icons.grid_view, "Balcão", 2),
              _buildNavItem(Icons.person_outline, "Perfil", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFF512DA8),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: isSelected ? 18 : 24),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
