// feito por camila fernandes costacurta RA:25012949 
import 'package:flutter/material.dart';

import 'app_storage.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  bool _mfaEnabled = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSecurityConfig();
  }

  Future<void> _loadSecurityConfig() async {
    final mfaEnabled = await AppStorage.getCurrentUserMfaEnabled();
    if (!mounted) return;
    setState(() {
      _mfaEnabled = mfaEnabled;
      _loading = false;
    });
  }

  Future<void> _onToggleMfa(bool value) async {
    await AppStorage.setCurrentUserMfaEnabled(value);
    if (!mounted) return;
    setState(() => _mfaEnabled = value);

    if (value) {
      Navigator.pushNamed(context, '/mfa');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil e seguranca')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              value: _mfaEnabled,
              onChanged: _onToggleMfa,
              title: const Text('Autenticacao de dois fatores (MFA)'),
              subtitle: const Text(
                'Exigir codigo adicional ao acessar a conta',
              ),
            ),
            const SizedBox(height: 12),
            if (_mfaEnabled)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/mfa'),
                  child: const Text('Validar MFA agora'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
