import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_password_field.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/presentation/auth/sign_up/bloc/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
    _confirmPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go("/form");
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
                          "Login va parol orqali ro'yxatdan o'tish",
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
                              'Telefon raqamini faqat raqamlar bilan kiriting. Parolni 6-32 belgi orasida yozing va takrorlang.',
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
                        const SizedBox(height: 16),
                        CustomPasswordField(
                          hint: "Parolni takrorlang",
                          controller: _confirmPasswordController,
                          maxLength: 32,
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                              text: "Ro'yxatdan o'tish",
                              isLoading: state.isLoading,
                              onPressed:
                                  _loginController.text.isEmpty ||
                                      _passwordController.text.length < 6 ||
                                      _confirmPasswordController.text.length < 6 ||
                                      _passwordController.text !=
                                          _confirmPasswordController.text
                                  ? null
                                  : () {
                                      context.read<SignupBloc>().add(
                                        SignupButtonPressed(
                                          email:
                                              "${_loginController.text.replaceAll(" ", "")}@tiiame.com",
                                          password: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                        ),
                                      );
                                    },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomOutlinedButton(
                          text: "Kirish",
                          onPressed: () {
                            context.push("/log-in");
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
