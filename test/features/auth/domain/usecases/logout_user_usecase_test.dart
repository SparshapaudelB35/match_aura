import 'package:flutter_test/flutter_test.dart';
import 'package:match_aura/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:match_aura/core/error/failures.dart';

// Mock repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogoutUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LogoutUsecase(authRepository: mockAuthRepository);
  });

  group('LogoutUsecase', () {
    test('should return true when logout is successful', () async {
      // Arrange
      when(() => mockAuthRepository.logout())
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right(true));
      verify(() => mockAuthRepository.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when logout fails', () async {
      // Arrange
      final tFailure = ApiFailure(message: 'Logout failed');
      when(() => mockAuthRepository.logout())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockAuthRepository.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
