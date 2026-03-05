import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';
part 'login_event.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(const LoginState.initial()) {
    on<_SubmitLogin>(_onSubmitLogin);
    on<_SubmitGoogleLogin>(_onSubmitGoogleLogin);
    on<_SubmitFirebaseLogin>(_onSubmitFirebaseLogin);
  }

  FutureOr<void> _onSubmitLogin(_SubmitLogin event, Emitter<LoginState> emit) async {
    emit(const LoginState.loadInProgress());
    try {
      await _authRepository.signInWithEmailAndPassword(event.username, event.password);
      emit(const LoginState.loginSuccess());
    } on Exception catch (e) {
      emit(LoginState.failure(e.toString()));
    }
  }

  FutureOr<void> _onSubmitGoogleLogin(_SubmitGoogleLogin event, Emitter<LoginState> emit) async {
    emit(const LoginState.loadInProgress());
    try {
      await _authRepository.signInWithGoogle();
      emit(const LoginState.loginSuccess());
    } on Exception catch (e) {
      emit(LoginState.failure(e.toString()));
    }
  }

  FutureOr<void> _onSubmitFirebaseLogin(_SubmitFirebaseLogin event, Emitter<LoginState> emit) async {
    emit(const LoginState.loadInProgress());
    try {
      await _authRepository.signInWithFirebase();
      emit(const LoginState.loginSuccess());
    } on Exception catch (e) {
      emit(LoginState.failure(e.toString()));
    }
  }
}
