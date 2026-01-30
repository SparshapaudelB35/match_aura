import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/error/failures.dart';
import 'package:match_aura/core/services/connectivity/network_info.dart';
import 'package:match_aura/features/auth/data/datasources/auth_datasource.dart';
import 'package:match_aura/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:match_aura/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:match_aura/features/auth/data/models/auth_api_model.dart';
import 'package:match_aura/features/auth/data/models/auth_hive_model.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';
import 'package:match_aura/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(
    authDatasource: ref.read(authLocalDatasourceProvider),
    authRemoteDataSource: ref.read(authRemoteDatasourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

class AuthRepository implements IAuthRepository {
  final IAuthLocalDatasource _authDatasource;
  final IAuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;
  AuthRepository({
    required IAuthLocalDatasource authDatasource,
    required IAuthRemoteDataSource authRemoteDataSource,
    required NetworkInfo networkInfo,
  }) : _authDatasource = authDatasource,
       _authRemoteDataSource = authRemoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authDatasource.getCurrentUser();
      if (user != null) {
        final entity = user.toEntity();
        return Right(entity);
      } else {
        return Left(LocalDatabaseFailure(message: 'No User Logged in'));
      }
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login(
    String email,
    String password,
  ) async {
    if(await _networkInfo.isConnected){
      try{
        final apiModel = await _authRemoteDataSource.login(email, password);
        if(apiModel !=null){
          final entity = apiModel.toEntity();
          return Right(entity);
        }
        return const Left(ApiFailure(message: "Invalid credentials"));
      }on DioException catch(e){
        return Left(
          ApiFailure(
            message: e.response?.data['message'] ?? 'Login failed',
            statusCode: e.response?.statusCode, 
          ),
        );
      } catch(e){
        return Left(ApiFailure(message: e.toString()));
      }
    }else{
      try {
      final model = await _authDatasource.login(email, password);
      if (model != null) {
        final entity = model.toEntity();
        return Right(entity);
      }
      return const Left(
        LocalDatabaseFailure(message: 'Invalid email or password'),
      );
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
    }
    
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await _authDatasource.logout();
      if (result) {
        return Right(true);
      } else {
        return left(LocalDatabaseFailure(message: 'Failed to logout user'));
      }
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> register(AuthEntity user) async {
    final isConnected = await _networkInfo.isConnected;
    
    if (isConnected) {
      try {
        final apiModel = AuthApiModel.fromEntity(user);
        await _authRemoteDataSource.register(apiModel);
        return const Right(true);
      } on DioException catch (e) {
        final errorMsg = e.response?.data['message'] ?? e.message ?? 'Registration failed';
        return Left(
          ApiFailure(
            message: errorMsg,
            statusCode: e.response?.statusCode,
          ),
        );
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      try {
        final authModel = AuthHiveModel(
          fullName: user.fullName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          username: user.username,
          password: user.password,
          profilePicture: user.profilePicture,
        );
        await _authDatasource.register(authModel);
        return const Right(true);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> UploadImage(File image) async{
    if(await _networkInfo.isConnected ){
      try{
        final fileName = await _authRemoteDataSource.uploadImage(image);
        return Right(fileName);
      }catch (e){
        return Left(ApiFailure(message: e.toString()));
      }
    }else{
      return Left(ApiFailure(message: "No internet connection"));
    }
  }
}
