import 'package:catch_all_app/domain/models/user_model.dart';

abstract class IAuthRepository {
  /// Sign in with Google
  Future<UserModel> signInWithGoogle();

  /// Get current user if logged in
  Future<UserModel?> getCurrentUser();

  /// Sign out
  Future<void> signOut();
}
