import 'package:firebase_assignment/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  String? getUserDisplayName(MyUser user) {
    return user.displayName;
  }

}
