import 'package:bloc_test/bloc_test.dart';
import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:catch_all_app/ui/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginBloc loginBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginBloc = LoginBloc(mockAuthRepository);
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginBloc', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tUser = UserModel(id: '1', email: tEmail, displayName: 'Test User');

    test('initial state should be LoginState.initial()', () {
      expect(loginBloc.state, const LoginState.initial());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [loadInProgress, loginSuccess] when submitLogin succeeds',
      build: () {
        when(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).thenAnswer((_) async => tUser);
        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitLogin(username: tEmail, password: tPassword)),
      expect: () => [const LoginState.loadInProgress(), const LoginState.loginSuccess()],
      verify: (_) {
        verify(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loadInProgress, failure] when submitLogin fails',
      build: () {
        when(
          () => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword),
        ).thenThrow(Exception('Login failed'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitLogin(username: tEmail, password: tPassword)),
      expect: () => [const LoginState.loadInProgress(), const LoginState.failure('Exception: Login failed')],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loadInProgress, loginSuccess] when submitGoogleLogin succeeds',
      build: () {
        when(() => mockAuthRepository.signInWithGoogle()).thenAnswer((_) async => tUser);
        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent.submitGoogleLogin()),
      expect: () => [const LoginState.loadInProgress(), const LoginState.loginSuccess()],
    );
  });
}
