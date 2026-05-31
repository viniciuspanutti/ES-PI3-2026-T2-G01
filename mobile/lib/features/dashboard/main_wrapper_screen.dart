import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
import 'package:mobile/features/wallet/presentation/trade_market.dart'
    as camila_market;
import 'package:mobile/features/profile/presentation/profile_screen.dart';
import 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const WalletDashboardScreen(),
        const CatalogoStartupsPage(),
        _buildBalcaoComTrava(),
        const ProfileScreen(),
      ][_currentIndex],
      // ── BARRA DE NAVEGAÇÃO GLOBAL ─────────────────────────────────────────────
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
              child: _buildNavItem(Icons.grid_view, "Balcão", 2),
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

  // ── TRAVA DA REGRA DE INVESTIDOR PARA O BALCÃO ────────────────────────────────────
  Widget _buildBalcaoComTrava() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return _buildBalcaoBloqueado();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('investimentos')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

      if (FirebaseAuth.instance.currentUser == null) {
        return _buildBalcaoBloqueado();
      }

        final docs = snapshot.data?.docs ?? [];
        final isInvestor = docs.any((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return (data['tokensComprados'] ?? 0) > 0;
        });

        if (isInvestor) {
          return const camila_market.BalcaoNegociacaoPage();
        }

        return _buildBalcaoBloqueado();
      },
    );
  }

  Widget _buildBalcaoBloqueado() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EDFF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF512DA8).withValues(alpha: 0.10),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF512DA8),
                  size: 42,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Balcão Bloqueado',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1D1D1F),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Você precisa estudar uma startup e fazer seu '
                'primeiro investimento através do Catálogo para '
                'desbloquear o Balcão Global.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
