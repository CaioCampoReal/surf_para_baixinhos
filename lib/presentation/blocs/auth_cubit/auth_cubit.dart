import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/sign_in_with_email.dart';
import '../../../domain/usecases/register_with_email.dart';
import '../../../domain/usecases/create_admin_user.dart';
import '../../../domain/usecases/sign_out.dart';
import '../../../domain/usecases/get_current_user.dart';
import '../../../core/errors/auth_failures.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmail signInWithEmail;
  final RegisterWithEmail registerWithEmail;
  final CreateAdminUser createAdminUser;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

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
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    emit(AuthLoading());
    
    final result = await getCurrentUser();
    result.fold(
      (failure) => emit(AuthUnAuthenticated()),
      (user) => emit(AuthAuthenticated(user: user)),
    );
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
      (user) => emit(AuthAuthenticated(user: user)),
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
      (user) => emit(AuthAuthenticated(user: user)),
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
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());

    final result = await signOut();
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(AuthUnAuthenticated()),
    );
  }

  void clearError() {
    if (state is AuthError) {
      emit(AuthUnAuthenticated());
    }
  }

  bool get isAdmin {
    return state is AuthAuthenticated && 
           (state as AuthAuthenticated).user.isAdmin;
  }

  User? get currentUser {
    return state is AuthAuthenticated ? 
           (state as AuthAuthenticated).user : null;
  }
}