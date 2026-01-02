import 'package:dartz/dartz.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';


abstract interface class IAuthRepository{
  Future<Either<Failure,bool>> register(AuthEntity entity);
  Future<Either<Failure,AuthEntity>>login(String email,String password);
  Future<Either<Failure,AuthEntity>> getCurrentUser();
  Future<Either<Failure,bool>> logout();

}