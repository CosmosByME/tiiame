import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiiame/presentation/auth/log_in/view/log_in_page.dart';
import 'package:tiiame/presentation/auth/sign_up/view/sign_up_page.dart';
import 'package:tiiame/presentation/form/view/form_page.dart';
import 'package:tiiame/presentation/main_page/view/home_page.dart';

final router = GoRouter(
  initialLocation: '/',
  // This forces GoRouter to re-run the redirect logic instantly whenever auth state changes
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),

  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/sign-up', builder: (context, state) => const SignUpPage()),
    GoRoute(path: '/log-in', builder: (context, state) => const LogInPage()),
    GoRoute(path: '/form', builder: (context, state) => const FormPage()),
  ],

  redirect: (context, state) {
    final loggedIn = FirebaseAuth.instance.currentUser != null;

    // Check what type of page the user is trying to access
    final isAccessingAuthPage =
        state.matchedLocation == '/log-in' ||
        state.matchedLocation == '/sign-up';

    // 1. If not logged in and trying to go to a protected page -> Force Log In
    if (!loggedIn && !isAccessingAuthPage) {
      return '/sign-up';
    }

    // 2. If logged in and trying to access Log In / Sign Up pages -> Send to Home
    if (loggedIn && isAccessingAuthPage) {
      return '/';
    }

    // Keep the current route if no rules are violated
    return null;
  },
);

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
