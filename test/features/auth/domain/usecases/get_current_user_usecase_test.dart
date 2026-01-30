import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:match_aura/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:match_aura/core/error/failures.dart';

// Mock the repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCurrentUserUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentUserUsecase(authRepository: mockAuthRepository);
  });

  final tAuthEntity = AuthEntity(
    authId: '123',
    fullName: 'John Doe',
    email: 'john@example.com',
    phoneNumber: '+9779800000000',
     username: 'johndoe',
  );

  group('GetCurrentUserUsecase', () {
    test('should return AuthEntity when repository returns success', () async {
      // Arrange
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => Right(tAuthEntity));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Right(tAuthEntity));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when repository fails', () async {
      // Arrange
      final tFailure = ApiFailure(message: 'Server error');
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
