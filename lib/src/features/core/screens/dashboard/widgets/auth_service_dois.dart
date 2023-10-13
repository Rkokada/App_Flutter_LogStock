import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceDois {
  


  final FirebaseAuth _firebaseAuth2 = FirebaseAuth.instance;

  Stream<User?> onAuthStateChange() {
    return _firebaseAuth2.authStateChanges();
  }

  User? currentUser() {
    return _firebaseAuth2.currentUser;
  }

  Future<void> register(
      {required String firstName,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth2
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateProfile(
          displayName: firstName,
          photoURL: "https://ui-avatars.com/api/?name=$firstName");
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth2.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth2.signOut();
  }
}
