import 'package:tiiame/data/services/auth_service.dart';

class AuthUseCase {
  Future<void> signIn(String email, String password) async {
    AuthService authService = AuthService();
    await authService.signInWithEmailAndPassword(email, password);    
  }


  Future<void> signUp(String email, String password) async {
    AuthService authService = AuthService();
    await authService.createUserWithEmailAndPassword(email, password);
  }
}