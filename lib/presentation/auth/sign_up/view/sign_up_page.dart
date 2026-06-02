import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_password_field.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/presentation/auth/sign_up/bloc/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
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
          context.pushReplacement("/form");
        }
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("background/photo1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TIQXMMI MTU AFIM",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Login va parol orqali ro'yxatdan o'tish",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      CustomTextField(
                        hint: "Login",
                        controller: _phoneController,
                      ),
                      SizedBox(height: 16),
                      CustomPasswordField(
                        hint: "Parol",
                        controller: _passwordController,
                      ),
                      SizedBox(height: 16),
                      CustomPasswordField(
                        hint: "Parolni takrorlang",
                        controller: _confirmPasswordController,
                      ),
                      SizedBox(height: 24),
                      BlocBuilder<SignupBloc, SignupState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: "Ro'yxatdan o'tish",
                            isLoading: state.isLoading,
                            onPressed:
                                _phoneController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _confirmPasswordController.text.isEmpty ||
                                    _passwordController.text !=
                                        _confirmPasswordController.text
                                ? null
                                : () {
                                    context.read<SignupBloc>().add(
                                      SignupButtonPressed(
                                        email:
                                            "${_phoneController.text.replaceAll(" ", "")}@tiiame.com",
                                        password: _passwordController.text,
                                        confirmPassword:
                                            _confirmPasswordController.text,
                                      ),
                                    );
                                  },
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      CustomOutlinedButton(
                        text: "Kirish",
                        onPressed: () {
                          context.pushReplacement("/");
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
    );
  }
}
