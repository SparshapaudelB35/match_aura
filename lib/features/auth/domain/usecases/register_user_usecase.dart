import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/core/usecase/app_usecase.dart';
import 'package:match_aura/features/auth/data/repositories/auth_repository.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserParams extends Equatable{
   final String? authId;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String username;
  final String? password;

  const RegisterUserParams({
    this.authId,
    required this.fullName, 
    required this.email,
    this.phoneNumber, 
    required this.username,
    this.password,
  });


  @override
  List<Object?> get props => [
    authId,
    fullName,
    email,
    phoneNumber,
    username,
    password,
  ];
  }

  final registerUserUsecaseProvider = Provider<RegisterUserUsecase>((ref){
    final authRepository = ref.read(authRepositoryProvider);
    return RegisterUserUsecase(authRepository: authRepository);
  });

  class RegisterUserUsecase implements UsecaseWithParams<bool, RegisterUserParams>{

    final IAuthRepository _authRepository;
    RegisterUserUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;
    
  @override
  Future<Either<Failure, bool>> call(RegisterUserParams params) {
    final entity = AuthEntity(
      fullName: params.fullName, 
      email: params.email, 
      phoneNumber: params.phoneNumber,
      username: params.username,
      password: params.password
      );
    return _authRepository.register(entity);
  }

  }