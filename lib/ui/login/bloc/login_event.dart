part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitLogin({
    required String username,
    required String password,
  }) = _SubmitLogin;

  const factory LoginEvent.submitGoogleLogin() = _SubmitGoogleLogin;
  const factory LoginEvent.submitFirebaseLogin() = _SubmitFirebaseLogin;
}
