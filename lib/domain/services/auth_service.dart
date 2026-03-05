import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:client_api/client_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<ApiResult<UserModel>> signInWithGoogle();
  Future<ApiResult<UserModel>> signInWithFirebase();
  Future<ApiResult<UserModel>> signInWithEmailAndPassword(String email, String password);

  User? get currentUser;
  Future<void> signOut();
}
