import 'package:firebase_assignment/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/authentication_repository.dart';
import '../states/authentication_state.dart';

part 'authentication_provider.g.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  throw UnimplementedError();
});

@riverpod
class AuthenticationNotifier extends _$AuthenticationNotifier {
  late final AuthenticationRepository _authRepository;

  @override
  AuthenticationState build() {
    _authRepository = ref.read(authenticationRepositoryProvider);
    return AuthenticationState.initial();
  }

  Future<void> signInWithGoogle() async {
    state = AuthenticationState.loading();
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        state = AuthenticationState.authenticated(MyUser.fromFirebaseUser(user));
      } else {
        state = AuthenticationState.error("Failed to sign in with Google");
      }
    } catch (e) {
      state = AuthenticationState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = AuthenticationState.unauthenticated();
  }

  void loadCurrentUser() {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      state = AuthenticationState.authenticated(user as MyUser);
    } else {
      state = AuthenticationState.unauthenticated();
    }
  }

  String? getUserDisplayName() {
    final user = state.user;
    return user != null ? _authRepository.getUserDisplayName(user) : null;
  }

}
