import 'package:flutter/material.dart';
import 'features/startups/presentation/screens/auth_screens.dart';
import 'features/startups/presentation/screens/balcao_screen.dart';
import 'features/startups/presentation/screens/criar_um.dart';
import 'features/startups/presentation/screens/profile_security_screen.dart';
import 'features/startups/presentation/screens/wallet_dashboard_screen.dart';
import 'features/startups/presentation/screens/app_storage.dart';
import 'features/startups/presentation/screens/token_sale_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MesclaInvest',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepPurple),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/mfa': (context) => const MfaScreen(),
        '/wallet': (context) => const WalletDashboardPage(),
        '/balcao': (context) => const BalcaoNegociacaoPage(),
        '/profile-security': (context) => const ProfileSecurityScreen(),
        '/token-sale': (context) => TokenSaleScreen(
          startupId: ModalRoute.of(context)?.settings.arguments as String? ?? '',
          startupName: 'Startup',
        ),
      },
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Future<String?> _loadUser() {
    return AppStorage.getCurrentEmail();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data == null) {
          return const LoginScreen();
        }
        return const WalletDashboardPage();
      },
    );
  }
}
