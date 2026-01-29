import 'dart:io';

import 'package:match_aura/features/auth/data/models/auth_api_model.dart';
import 'package:match_aura/features/auth/data/models/auth_hive_model.dart';

abstract interface class IAuthLocalDatasource{
  Future<bool> register(AuthHiveModel user);
  Future<AuthHiveModel?>login(String email,String password);
  Future<AuthHiveModel?> getCurrentUser();
  Future<bool> logout();

  Future<bool> isEmailExists(String email);
}

abstract interface class IAuthRemoteDataSource{
  Future<AuthApiModel> register(AuthApiModel user);
  Future<AuthApiModel?>login(String email,String password);
  Future<AuthApiModel?> getUserById(AuthHiveModel authId);
  Future<String> uploadImage(File image); 
}