import 'dart:async';
import 'package:flutter/material.dart';

class MfaScreen extends StatefulWidget {
  const MfaScreen({super.key});

  @override
  State<MfaScreen> createState() => _MfaScreenState();
}

class _MfaScreenState extends State<MfaScreen> {
  static const int _codeLength = 5;
  static const int _initialSeconds = 30;

  final List<TextEditingController> _controllers = List.generate(
    _codeLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _codeLength,
    (_) => FocusNode(),
  );

  Timer? _timer;
  int _secondsRemaining = _initialSeconds;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) { controller.dispose(); }
    for (final focusNode in _focusNodes) { focusNode.dispose(); }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = _initialSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsRemaining--);
    });
  }

  String get _codeValue => _controllers.map((c) => c.text).join();

  bool get _canVerify =>
      _codeValue.length == _codeLength &&
      _codeValue.runes.every((char) => char >= 48 && char <= 57);

  void _onCodeChanged(int index, String value) {
    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verifyCode() async {
    if (!_canVerify || _isVerifying) return;
    setState(() => _isVerifying = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isVerifying = false);
    Navigator.pushReplacementNamed(context, '/wallet');
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoEscuro = Color(0xFF1F1435);
    const Color roxoDestaque = Color(0xFF4A2A84);
    const Color cinzaFundo = Color(0xFF6B6B6B);

    return Scaffold(
      backgroundColor: cinzaFundo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 4, backgroundColor: roxoEscuro),
                  Container(width: 40, height: 1, color: roxoEscuro),
                  const CircleAvatar(radius: 4, backgroundColor: roxoEscuro),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'CRIE SUA CONTA',
                style: TextStyle(
                  color: roxoEscuro,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'VERIFICAÇÃO DE\nSEGURANÇA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: roxoDestaque,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Insira o código de 5 dígitos',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            _codeLength,
                            (index) => _buildCodeField(index),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _canVerify ? _verifyCode : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: roxoDestaque,
                            // AQUI: Usando withValues em vez de withOpacity
                            disabledBackgroundColor: roxoDestaque.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          child: _isVerifying
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Acessar Conta',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _secondsRemaining == 0 ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13092D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _secondsRemaining == 0
                        ? 'Concluir o Cadastro'
                        : 'Concluir o Cadastro (${_secondsRemaining}s)',
                    style: TextStyle(
                      color: _secondsRemaining == 0 ? Colors.white : Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeField(int index) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: Color(0xFF4A2A84),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: const Color(0xFFEFEFEF),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF7D48CB), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF4A2A84), width: 2),
          ),
        ),
        onChanged: (value) => _onCodeChanged(index, value),
      ),
    );
  }
}
