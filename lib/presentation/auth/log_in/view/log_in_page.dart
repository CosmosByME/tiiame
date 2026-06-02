import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_password_field.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/presentation/auth/log_in/bloc/login_bloc.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loginController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go('/');
        }
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/photo1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "TIQXMMI MTU AFIM",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Login va parol orqali kirish",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const InfoWidget(
                          icon: 'ℹ️',
                          text:
                              'Login uchun telefon raqamingizni faqat raqamlar bilan kiriting. Parol kamida 6 ta belgidan iborat bo\'lsin.',
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: "Login",
                          controller: _loginController,
                        ),
                        const SizedBox(height: 16),
                        CustomPasswordField(
                          hint: "Parol",
                          controller: _passwordController,
                          maxLength: 32,
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                              text: "Kirish",
                              isLoading: state.isLoading,
                              onPressed:
                                  _loginController.text.isEmpty ||
                                      _passwordController.text.length < 6
                                  ? null
                                  : () {
                                      context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          email:
                                              "${_loginController.text.replaceAll(" ", "")}@tiiame.com",
                                          password: _passwordController.text,
                                        ),
                                      );
                                    },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomOutlinedButton(
                          text: "Ro'yxatdan o'tish",
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
