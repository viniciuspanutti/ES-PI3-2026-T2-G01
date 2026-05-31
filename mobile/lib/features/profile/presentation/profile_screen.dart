// Vinícius Panutti Salgado - 25007329
// ── profile_screen.dart ────────────────────────────────────────────────
// Tela de Perfil do utilizador — Autor: Vinícius Panutti
//
// Responsabilidades:
//   1. Exibir o toggle de ativação/desativação do MFA (2FA)
//   2. Persistir a preferência de MFA no SharedPreferences local
//   3. Fornecer o botão de Logout que encerra a sessão Firebase
//
// Arquitetura:
//   O estado do MFA é armazenado LOCALMENTE (SharedPreferences) com
//   chave 'mfa_enabled_{uid}'. Quando o utilizador faz login e tem
//   MFA ativado, o login_screen.dart verifica esta flag e redireciona
//   para a MfaVerificationScreen antes de completar a navegação.
//
// Fluxo de Logout:
//   1. Chama FirebaseAuth.instance.signOut() (invalida sessão na nuvem)
//   2. Navega para '/login' removendo TODA a pilha (pushNamedAndRemoveUntil)
//   3. O StreamBuilder no main.dart detecta a mudança de estado e
//      mostraria a HomeScreen, mas como já navegamos para '/login',
//      o efeito é transparente para o utilizador.
// ──────────────────────────────────────────────────────────────────────
/*Vinicius Panutti
 * Explicação -> 
 */
import 'package:flutter/material.dart';
// Firebase Auth — para signOut() e acesso ao currentUser
import 'package:firebase_auth/firebase_auth.dart';
// SharedPreferences — armazenamento local chave-valor para a flag MFA
import 'package:shared_preferences/shared_preferences.dart';

// ── ProfileScreen — Widget com estado (StatefulWidget) ───────────────
// StatefulWidget porque precisa manter e atualizar o estado do toggle
// de MFA (_isMfaEnabled) quando o utilizador interage com o switch.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Flag que indica se o MFA está ativado para o utilizador atual.
  // Inicializada como false e atualizada no initState via _loadMfaState().
  bool _isMfaEnabled = false;

  @override
  void initState() {
    super.initState();
    // Carrega a preferência de MFA salva localmente ao abrir a tela
    _loadMfaState();
  }

  // ── _loadMfaState — Carrega estado do MFA do armazenamento local ──
  // Lê a chave 'mfa_enabled_{uid}' do SharedPreferences.
  // A chave inclui o UID para suportar múltiplos utilizadores no
  // mesmo dispositivo (cada um com sua configuração de MFA).
  Future<void> _loadMfaState() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        // getBool retorna null se a chave não existir, ?? false garante default
        _isMfaEnabled = prefs.getBool('mfa_enabled_${user.uid}') ?? false;
      });
    }
  }

  // ── _toggleMfa — Alterna o estado do MFA (ativa/desativa) ──────────
  // Chamado pelo SwitchListTile quando o utilizador toca no toggle.
  // Persiste a nova preferência no SharedPreferences e atualiza a UI.
  Future<void> _toggleMfa(bool value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      // Salva a preferência com chave específica por UID
      await prefs.setBool('mfa_enabled_${user.uid}', value);
      // Atualiza a UI via setState para refletir o novo estado do toggle
      setState(() {
        _isMfaEnabled = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Toggle de MFA ──────────────────────────────────────────
          // SwitchListTile combina um Switch com título e subtítulo
          // num único widget Material. O activeThumbColor usa o roxo
          // da marca quando ativado.
          SwitchListTile(
            title: const Text('Autenticação de Dois Fatores (MFA)'),
            subtitle: const Text('Exige um código extra ao fazer login.'),
            value: _isMfaEnabled,
            onChanged: _toggleMfa,
            activeThumbColor: const Color(0xFF512DA8),
          ),
          const SizedBox(height: 20),
          // ── Botão de Logout ────────────────────────────────────────
          // Botão vermelho que encerra a sessão do utilizador.
          // Fluxo:
          //   1. signOut() → invalida token Firebase na nuvem
          //   2. context.mounted → verifica se o widget ainda está na árvore
          //   3. pushNamedAndRemoveUntil → limpa TODA a pilha de navegação
          //      e redireciona para '/login', impedindo o botão "voltar"
          //      de retornar a telas autenticadas após logout.
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              // Encerra a sessão Firebase (invalida tokens)
              await FirebaseAuth.instance.signOut();
              // Verifica se o widget ainda está montado (evita crash
              // se o utilizador sair da tela durante o signOut)
              if (context.mounted) {
                // Navega para login removendo TODA a pilha
                // (route) => false descarta todas as rotas anteriores
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            child: const Text(
              'Fazer Logout',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

