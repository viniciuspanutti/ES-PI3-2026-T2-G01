import 'package:flutter/material.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
import 'package:mobile/features/wallet/presentation/trading_market_screen.dart';
import 'package:mobile/features/profile/presentation/security_settings_screen.dart';
import 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const WalletDashboardScreen(),
    const CatalogoStartupsPage(),
    const BalcaoNegociacaoPage(),
    const ProfileSecurityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      // â”€â”€ BARRA DE NAVEGAÃ‡ÃƒO GLOBAL â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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
            GestureDetector(
              onTap: () => setState(() => _currentIndex = 0),
              child: _buildNavItem(Icons.home_outlined, "Home", 0),
            ),
            GestureDetector(
              onTap: () => setState(() => _currentIndex = 1),
              child: _buildNavItem(Icons.search, "Explorar", 1),
            ),
            GestureDetector(
              onTap: () => setState(() => _currentIndex = 2),
              child: _buildNavItem(Icons.grid_view, "BalcÃ£o", 2),
            ),
            GestureDetector(
              onTap: () => setState(() => _currentIndex = 3),
              child: _buildNavItem(Icons.person_outline, "Perfil", 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    if (isSelected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF512DA8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.transparent,
        child: Icon(icon, color: Colors.white),
      );
    }
  }
}
