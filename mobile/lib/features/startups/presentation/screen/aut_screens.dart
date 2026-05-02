import 'package:flutter/material.dart';
import '../../../home/components/btn_cadastrar.dart';
import '../../../home/components/btn_email_enviado.dart';
import '../../../home/components/btn_home.dart';
import '../../../home/components/btn_login.dart';
import '../../../home/components/btn_rec_senha.dart';
import '../../../home/components/btn_login_senha.dart';
import '../../../home/components/seta_voltar.dart';

import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
    });

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();

    try {
      final needsMfa = await AuthService.login(email: email, password: password);
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      if (needsMfa) {
        Navigator.pushReplacementNamed(context, '/mfa');
      } else {
        Navigator.pushReplacementNamed(context, '/wallet');
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha no login. Verifique e-mail e senha.')),
      );
    }
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: SetaVoltar(ontap: () => Navigator.maybePop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o e-mail';
                  }
                  if (!value.contains('@')) return 'E-mail invalido';
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Senha minima de 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                BotaoLogin(onTap: _login),
              MudarSenha(
                onTap: () => Navigator.pushNamed(context, '/forgot'),
              ),
              const SizedBox(height: 8),
              FazerLogin(onTap: _goToRegister),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim().toLowerCase();
    try {
      await AuthService.register(
        name: _nameController.text.trim(),
        email: email,
        cpf: _cpfController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro concluido. Faca login para continuar.')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nao foi possivel cadastrar. Confira os dados informados.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        leading: SetaVoltar(ontap: () => Navigator.maybePop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_nameController, 'Nome completo', (value) {
                if (value == null || value.trim().split(' ').length < 2) {
                  return 'Informe nome completo';
                }
                return null;
              }),
              _field(_emailController, 'E-mail', (value) {
                if (value == null || !value.contains('@')) {
                  return 'E-mail invalido';
                }
                return null;
              }),
              _field(_cpfController, 'CPF', (value) {
                final clean = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
                if (clean.length != 11) return 'CPF deve ter 11 digitos';
                return null;
              }),
              _field(_phoneController, 'Telefone celular', (value) {
                final clean = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
                if (clean.length < 10) return 'Telefone invalido';
                return null;
              }),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Senha minima de 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              BotaoCadastrar(onTap: _register),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    String? Function(String?) validator,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _instructionsSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendInstructions() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim().toLowerCase();
    try {
      await AuthService.sendPasswordReset(email);
      if (!mounted) return;
      setState(() => _instructionsSent = true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text('Nao foi possivel enviar as instrucoes para esse e-mail.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar senha'),
        leading: SetaVoltar(ontap: () => Navigator.maybePop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _instructionsSent
            ? Center(
                child: BotaoVoltarMenu(
                  onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'E-mail invalido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    BotaoRecuperar(onTap: _sendInstructions),
                  ],
                ),
              ),
      ),
    );
  }
}
