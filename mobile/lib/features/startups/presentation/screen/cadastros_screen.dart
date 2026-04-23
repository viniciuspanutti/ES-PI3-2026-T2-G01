import 'package:flutter/material.dart';

const _brandPurple = Color(0xFF5A3296);
const _outerBackground = Color(0xFFD9D9D9);
const _dividerColor = Color(0xFFE6E1E1);
const _fieldBackground = Color(0xFFF9F8F8);
const _fieldHintColor = Color(0xFFB9B1B1);
const _fieldTextColor = Color(0xFF6F6969);
const _focusedBorderColor = Color(0x335A3296);
const _headingFontFamily = 'MarcellusSC';
const _serifFontFamily = 'Marcellus';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: _brandPurple),
        scaffoldBackgroundColor: _outerBackground,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _brandPurple,
          selectionHandleColor: _brandPurple,
        ),
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: SizedBox(
                width: double.infinity,
                height: constraints.maxHeight,
                child: Material(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: mediaQuery.padding.top),
                      SizedBox(
                        height: 52,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: IconButton(
                              onPressed: () => Navigator.maybePop(context),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 20,
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: _dividerColor,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(32, 18, 32, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'CRIE SUA CONTA',
                                  style: TextStyle(
                                    color: _brandPurple,
                                    fontSize: 24.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.45,
                                    height: 1.0,
                                    fontFamily: _headingFontFamily,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 34),
                              const PrototypeField(
                                label: 'Nome Completo',
                                hintText: 'Jualino Correia Silva',
                                prefixIcon: Icons.person_outline_rounded,
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 18),
                              const PrototypeField(
                                label: 'E-mail',
                                hintText: 'minhaconta@gmail.com',
                                prefixIcon: Icons.mail_outline_rounded,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 18),
                              const PrototypeField(
                                label: 'CPF',
                                hintText: '230.432.632-74',
                                prefixIcon: Icons.badge_outlined,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 18),
                              const PrototypeField(
                                label: 'Telefone Celular',
                                hintText: '(19) 64232-8473',
                                prefixIcon: Icons.phone_android_rounded,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 18),
                              PrototypeField(
                                label: 'Senha',
                                hintText: 'Senha',
                                prefixIcon: Icons.lock_outline_rounded,
                                obscureText: _obscurePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  splashRadius: 18,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: 18,
                                    color: _fieldHintColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: _dividerColor),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          32,
                          22,
                          32,
                          24 + mediaQuery.padding.bottom,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _brandPurple,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Concluir o Cadastro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.5,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                                fontFamily: _serifFontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PrototypeField extends StatelessWidget {
  const PrototypeField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.5,
            fontWeight: FontWeight.w400,
            height: 1.0,
            fontFamily: _serifFontFamily,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: _fieldTextColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: _fieldHintColor,
              fontSize: 15,
            ),
            filled: true,
            fillColor: _fieldBackground,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 14, end: 10),
              child: Icon(
                prefixIcon,
                color: _fieldHintColor,
                size: 18,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 42,
              minHeight: 42,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: _focusedBorderColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
