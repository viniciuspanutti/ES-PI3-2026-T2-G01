import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/auth/data/user_service.dart';
import 'package:mobile/features/auth/domain/user_model.dart';
import 'package:mobile/core/routes/app_routes.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  final UserService _userService = UserService();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  UserModel? _userData;
  bool _isLoading = true;
  bool _isSaving = false;

  bool get _hasPin => _userData?.hasMfaEnabled == true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final user = await _userService.fetchCurrentUser();
      setState(() => _userData = user);
    } catch (e) {
      _showSnack('Erro ao carregar perfil: ${e.toString()}', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _savePin() async {
    final pin = _pinController.text.trim();
    final confirm = _confirmController.text.trim();

    if (pin.length < 4 || pin.length > 6) {
      _showSnack('O PIN deve ter entre 4 e 6 dígitos.', isError: true);
      return;
    }
    if (pin != confirm) {
      _showSnack('Os PINs não coincidem.', isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      await _userService.saveSecurityPin(pin);
      _showSnack('PIN salvo com sucesso!');
      _pinController.clear();
      _confirmController.clear();
      await _loadUserData();
    } catch (e) {
      _showSnack('Erro ao salvar PIN: ${e.toString()}', isError: true);
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red.shade700 : const Color(0xFF512DA8),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // CORREÇÃO: Seta de voltar agora usa SmartBack para nunca fechar o app
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF512DA8)),
          onPressed: () => AppRoutes.smartBack(context),
        ),
        title: Text(
          'Segurança da Conta',
          style: GoogleFonts.inter(color: const Color(0xFF512DA8), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF512DA8)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildPinForm(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.shield_rounded, color: Color(0xFF512DA8), size: 48),
        const SizedBox(height: 16),
        Text(
          _hasPin ? 'Alterar PIN' : 'Criar PIN de Segurança',
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPinForm() {
    return Column(
      children: [
        TextField(
          controller: _pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'PIN'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _confirmController,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Confirmar PIN'),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isSaving ? null : _savePin,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF512DA8)),
            child: const Text('Salvar PIN', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
