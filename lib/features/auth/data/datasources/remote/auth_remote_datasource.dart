import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/api/api_client.dart';
import 'package:match_aura/core/api/api_endpoints.dart';
import 'package:match_aura/core/services/storage/user_session_service.dart';
import 'package:match_aura/features/auth/data/datasources/auth_datasource.dart';
import 'package:match_aura/features/auth/data/models/auth_api_model.dart';
import 'package:match_aura/features/auth/data/models/auth_hive_model.dart';

final authRemoteDatasourceProvider = Provider<IAuthRemoteDataSource>((ref){
  return AuthRemoteDatasource(
    apiClient: ref.read(apiClientProvider),
    userSessionService: ref.read(UserSessionServiceProvider),
  );
});

class AuthRemoteDatasource implements IAuthRemoteDataSource{
  final ApiClient _apiClient;
  final UserSessionService _userSessionService;

  AuthRemoteDatasource({
    required ApiClient apiClient,
    required UserSessionService userSessionService,
  })  : _apiClient = apiClient,
        _userSessionService = userSessionService;

  @override
  Future<AuthApiModel?> getUserById(AuthHiveModel authId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<AuthApiModel?> login(String email, String password) async{
    final response = await _apiClient.post(
      ApiEndpoints.userLogin,
      data: {
        "email": email,
        "password": password,
      }
    );

    if(response.data['success'] == true){
      final data = response.data['data'] as Map<String, dynamic>;
      final user = AuthApiModel.fromJson(data);

      await _userSessionService.saveUserSession(
        userId: user.id!,
        email: user.email,
        username: user.username,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber);
      return user;
    }
    return null;
  }

  @override
  Future<AuthApiModel> register(AuthApiModel user) async {
    final response = await _apiClient.post(ApiEndpoints.users, data: user.toJson(),
    );

    if(response.data['success']== true){
      final data = response.data['data'] as Map<String, dynamic>;
      final registeredUser = AuthApiModel.fromJson(data);
      return registeredUser;
    }
    return user;
  }
}