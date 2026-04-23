import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../home/components/btn_login.dart';

class MfaScreen extends StatefulWidget {
  const MfaScreen({super.key});

  @override
  State<MfaScreen> createState() => _MfaScreenState();
}

class _MfaScreenState extends State<MfaScreen> {
  final Color roxoMescla = const Color(0xFF5A36BF);
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  bool get _isCodeComplete => _controllers.every((controller) => controller.text.isNotEmpty);

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF717171),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'VERIFICAÇÃO DE\nSEGURANÇA',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      color: roxoMescla,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Insira o código de 5 dígitos',
                    style: GoogleFonts.lora(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) => _buildDigitBox(index)),
                  ),
                  const SizedBox(height: 50),
                  Opacity(
                    opacity: _isCodeComplete ? 1 : 0.45,
                    child: IgnorePointer(
                      ignoring: !_isCodeComplete,
                      child: FazerLogin(
                        onTap: () {
                          Navigator.pushNamed(context, '/wallet');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDigitChanged(int index, String value) {
    setState(() {});
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
      return;
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Widget _buildDigitBox(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: roxoMescla.withValues(alpha: 0.2)),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: InputBorder.none, counterText: ""),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        onChanged: (value) => _onDigitChanged(index, value),
      ),
    );
  }
}

