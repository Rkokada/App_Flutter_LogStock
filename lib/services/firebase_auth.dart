import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> onAuthStateChange() {
    return _firebaseAuth.authStateChanges();
  }

  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> register(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateProfile(
          displayName: fullName,
          photoURL: "https://ui-avatars.com/api/?name=$fullName");
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
