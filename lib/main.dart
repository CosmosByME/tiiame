import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiiame/core/router/router.dart';
import 'package:tiiame/core/theme/app_theme.dart';
import 'package:tiiame/firebase_options.dart';
import 'package:tiiame/presentation/auth/log_in/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/presentation/auth/sign_up/bloc/signup_bloc.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.authStateChanges().first;
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormBloc(),
      child: BlocProvider(
        create: (context) => SignupBloc(),
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'TIQXMMI MTU AFIM',
            theme: AppTheme.appStyle,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }
}