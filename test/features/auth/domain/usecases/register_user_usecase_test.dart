import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:match_aura/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUserUsecase usecase;
  late MockAuthRepository repository;

  setUpAll(() {
    registerFallbackValue(
      const AuthEntity(
        fullName: 'fallback',
        email: 'fallback@email.com',
        username: 'fallback',
      ),
    );
  });

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUserUsecase(authRepository: repository);
  });

  const params = RegisterUserParams(
    fullName: "Test User",
    email: "test@mail.com",
    phoneNumber: "9800000000",
    username: "testuser",
    password: "123456",
  );

  test('1. calls repository.register()', () async {
    when(() => repository.register(any()))
        .thenAnswer((_) async => const Right(true));

    await usecase(params);

    verify(() => repository.register(any())).called(1);
  });

  test('2. returns Right(true) on success', () async {
    when(() => repository.register(any()))
        .thenAnswer((_) async => const Right(true));

    final result = await usecase(params);

    expect(result, const Right(true));
  });

  test('3. returns Left(Failure) on failure', () async {
    when(() => repository.register(any()))
        .thenAnswer((_) async => Left(NetworkFailure(message: 'error')));

    final result = await usecase(params);

    expect(result.isLeft(), true);
  });

  test('4. passes correct data to entity', () async {
    when(() => repository.register(any()))
        .thenAnswer((_) async => const Right(true));

    await usecase(params);

    final captured = verify(() => repository.register(captureAny()))
        .captured
        .single as AuthEntity;

    expect(captured.email, params.email);
  });

  test('5. works when optional fields are null', () async {
    const nullParams = RegisterUserParams(
      fullName: 'Test',
      email: 'test@mail.com',
      username: 'test',
      password: '123456'
    );

    when(() => repository.register(any()))
        .thenAnswer((_) async => const Right(true));

    final result = await usecase(nullParams);

    expect(result, const Right(true));
  });
}
