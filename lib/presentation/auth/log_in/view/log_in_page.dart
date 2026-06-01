import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_password_field.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/presentation/auth/log_in/bloc/login_bloc.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Muvaffaqiyatli kirildi!")),
          );
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
                        "Login va parol orqali kirish",
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
                      SizedBox(height: 24),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: "Kirish",
                            isLoading: state.isLoading,
                            onPressed:
                                _phoneController.text.isEmpty ||
                                    _passwordController.text.isEmpty
                                ? null
                                : () {
                                    context.read<LoginBloc>().add(
                                      LoginButtonPressed(
                                        email:
                                            "${_phoneController.text.replaceAll(" ", "")}@tiiame.com",
                                        password: _passwordController.text,
                                      ),
                                    );
                                  },
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      CustomOutlinedButton(
                        text: "Ro'yxatdan o'tish",
                        onPressed: () {
                          context.pushReplacement("/sign-up");
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
