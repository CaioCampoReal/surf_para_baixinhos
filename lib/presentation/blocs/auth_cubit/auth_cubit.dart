import 'package:bloc/bloc.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/sign_in_with_email.dart';
import '../../../domain/usecases/register_with_email.dart';
import '../../../domain/usecases/create_admin_user.dart';
import '../../../domain/usecases/sign_out.dart';
import '../../../domain/usecases/get_current_user.dart';
import 'auth_state.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmail signInWithEmail;
  final RegisterWithEmail registerWithEmail;
  final CreateAdminUser createAdminUser;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  StreamSubscription<firebase_auth.User?>? _authSubscription;

  AuthCubit({
    required this.signInWithEmail,
    required this.registerWithEmail,
    required this.createAdminUser,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    _authSubscription?.cancel();
    _authSubscription =
        firebase_auth.FirebaseAuth.instance.authStateChanges().listen(
      (firebaseUser) async {
        if (firebaseUser == null) {
          emit(AuthUnAuthenticated());
          return;
        }

        emit(AuthLoading());

        final result = await getCurrentUser();

        result.fold(
          (failure) => emit(AuthUnAuthenticated()),
          (user) => emit(AuthAuthenticated(user: user)),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await signInWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) {},
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    emit(AuthLoading());

    final result = await registerWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) {},
    );
  }

  Future<void> createAdmin({
    required String email,
    required String password,
    required String displayName,
  }) async {
    emit(AuthLoading());

    final result = await createAdminUser(
      email: email,
      password: password,
      displayName: displayName,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) {},
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await signOut();
  }

  bool get isAdmin {
    return state is AuthAuthenticated &&
        (state as AuthAuthenticated).user.isAdmin;
  }

  User? get currentUser {
    return state is AuthAuthenticated
        ? (state as AuthAuthenticated).user
        : null;
  }
}
