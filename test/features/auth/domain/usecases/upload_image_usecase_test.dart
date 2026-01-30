import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:match_aura/features/auth/domain/usecases/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';

// Mock repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late UploadPhotoUsecase usecase;
  
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadPhotoUsecase(authRepository: mockAuthRepository);

    // Required by mocktail when using File as a parameter
    registerFallbackValue(File(''));
  });

  group('UploadPhotoUsecase', () {
    final testFile = File('test_image.png');
    const testUrl = 'https://example.com/photo.png';

    test('should return a URL string when upload succeeds', () async {
      // Arrange
      when(() => mockAuthRepository.UploadImage(testFile))
          .thenAnswer((_) async => const Right(testUrl));

      // Act
      final result = await usecase(testFile);

      // Assert
      expect(result, const Right(testUrl));
      verify(() => mockAuthRepository.UploadImage(testFile)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when upload fails', () async {
      // Arrange
      final tFailure = ApiFailure(message: 'Upload failed');
      when(() => mockAuthRepository.UploadImage(testFile))
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(testFile);

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockAuthRepository.UploadImage(testFile)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
