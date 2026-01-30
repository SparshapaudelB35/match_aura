import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:match_aura/features/auth/domain/usecases/login_usecase.dart';
import 'package:match_aura/core/error/failures.dart';

// Mock the repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUsecase(authRepository: mockAuthRepository);
  });

  final tEmail = 'john@example.com';
  final tPassword = 'password123';
  final tParams = LoginUsecaseParams(email: tEmail, password: tPassword);

  final tAuthEntity = AuthEntity(
    authId: '123',
    fullName: 'John Doe',
    email: tEmail,
    phoneNumber: '+9779800000000',
    username: 'johndoe',
  );

  group('LoginUsecase', () {
    test('should return AuthEntity when login is successful', () async {
      // Arrange
      when(
        () => mockAuthRepository.login(tEmail, tPassword),
      ).thenAnswer((_) async => Right(tAuthEntity));

      // Act
      final result = await usecase(tParams);

      // Assert
      expect(result, Right(tAuthEntity));
      verify(() => mockAuthRepository.login(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when login fails', () async {
      // Arrange
      final tFailure = ApiFailure(message: 'Invalid credentials');
      when(
        () => mockAuthRepository.login(tEmail, tPassword),
      ).thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(tParams);

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockAuthRepository.login(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
