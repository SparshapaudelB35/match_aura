import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/core/usecase/app_usecase.dart';
import 'package:match_aura/features/auth/data/repositories/auth_repository.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';


// Create Provider
final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return GetCurrentUserUsecase(authRepository: authRepository);
});

class GetCurrentUserUsecase implements UsecaseWithoutParams<AuthEntity> {
  final IAuthRepository _authRepository;

  GetCurrentUserUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthEntity>> call() {
    return _authRepository.getCurrentUser();
  }
}