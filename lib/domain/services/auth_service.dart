import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:client_api/client_api.dart';

abstract class AuthService {
  Future<ApiResult<UserModel>> signInWithGoogle();
  Future<ApiResult<UserModel>> signInWithFirebase();
  Future<void> signOut();
}
