import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository _repository;

  LoginUseCase(this._repository);

  Future<UserModel> call(String email, String password) {
    return _repository.signInWithEmailAndPassword(email, password);
  }
}
