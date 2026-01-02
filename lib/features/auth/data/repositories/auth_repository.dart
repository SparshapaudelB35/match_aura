import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/features/auth/data/datasources/auth_datasource.dart';
import 'package:match_aura/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:match_aura/features/auth/data/models/auth_hive_model.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref){
  return AuthRepository(authDatasource: ref.read(authLocalDatasourceProvider));
});

class AuthRepository implements IAuthRepository{

  final IAuthDatasource _authDatasource;

  AuthRepository({required IAuthDatasource authDatasource})
  :_authDatasource=authDatasource;
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async{
    try {
      final user = await _authDatasource.getCurrentUser();
      if(user != null){
        final entity = user.toEntity();
        return Right(entity);
      }else{
       return Left(LocalDatabaseFailure(message: 'No User Logged in'));
      }
      
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
      
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login(String email, String password) async{
    try {
      final user = await _authDatasource.login(email, password);
      if(user != null){
        final entity = user.toEntity();
        return Right(entity);
      }
      return left(LocalDatabaseFailure(message: 'Invalid email or password'));
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await _authDatasource.logout();
      if(result){
        return Right(true);
      }else{
        return left(LocalDatabaseFailure(message: 'Failed to logout user'));
      }
      
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> register(AuthEntity entity) async {
    try {
      final model = AuthHiveModel.fromEntity(entity);
      final result = await _authDatasource.register(model);
      if(result){
        return Right(true);
      }else{
        return Left(LocalDatabaseFailure(message: 'Failed to register user'));
      }
      
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}