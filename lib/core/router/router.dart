import 'package:go_router/go_router.dart';
import 'package:tiiame/presentation/auth/log_in/view/log_in_page.dart';
import 'package:tiiame/presentation/auth/sign_up/view/sign_up_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LogInPage()),

    GoRoute(path: '/sign-up', builder: (context, state) => const SignUpPage()),
  ],
);
