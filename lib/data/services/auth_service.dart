import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiiame/core/toasts/error_toast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (_) {
      showErrorToast('Parol yoki email xato');
      rethrow;
    }
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (_) {
      showErrorToast('Xatolik yuz berdi');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}