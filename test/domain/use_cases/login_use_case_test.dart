import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:catch_all_app/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tUser = UserModel(id: '1', email: tEmail, displayName: 'Test User');

    test('should call signInWithEmailAndPassword from repository', () async {
      // Arrange
      when(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).thenAnswer((_) async => tUser);

      // Act
      final result = await loginUseCase.call(tEmail, tPassword);

      // Assert
      expect(result, tUser);
      verify(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(
        () => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword),
      ).thenThrow(Exception('Repository Error'));

      // Assert
      expect(() => loginUseCase.call(tEmail, tPassword), throwsException);
      verify(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).called(1);
    });
  });
}
