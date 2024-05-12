import 'package:firebase_auth/firebase_auth.dart';

import '../../services/authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService;

  AuthenticationRepository(this._authenticationService);

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      return await _authenticationService.signInWithGoogle();
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _authenticationService.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _authenticationService.getCurrentUser();
  }

  String? getUserDisplayName(User user) {
    return _authenticationService.getUserDisplayName(user);
  }
}