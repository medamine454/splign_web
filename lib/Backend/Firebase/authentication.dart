import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //SIGN UP METHOD
  Future signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = auth.currentUser!;
      user.updateDisplayName(username);
      await user.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      final user = auth.currentUser;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await auth.signOut();

    print('signout');
  }
}
