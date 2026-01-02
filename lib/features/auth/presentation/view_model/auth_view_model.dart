import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/features/auth/domain/usecases/login_usecase.dart';
import 'package:match_aura/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:match_aura/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = NotifierProvider<AuthViewModel,AuthState>(
  ()=> AuthViewModel());

class AuthViewModel extends Notifier<AuthState>{
  late final RegisterUserUsecase _registerUserUsecase;
  late final LoginUsecase _loginUsecase;
  
  @override
  AuthState build() {
    _registerUserUsecase = ref.read(registerUserUsecaseProvider);
    _loginUsecase = ref.read(loginUsecaseProvider);
    return AuthState();
  }
  
  Future<void> register({
    required String fullName,
    required String email,
    String? phoneNumber,
    required String username,
    required String password
  })async{
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(Duration(seconds: 2));
    final params = RegisterUserParams(
      fullName: fullName,
       email: email,
       phoneNumber: phoneNumber,
        username: username,
        password: password
        );
        final result = await _registerUserUsecase(params);
        result.fold(
          (failure){
            state = state.copyWith(
              status: AuthStatus.error,
              errorMessage: failure.message
            );
        }, (isRegistered){
          if(isRegistered){
            state = state.copyWith(
              status: AuthStatus.registered
            );
          }
        });
  }

  Future<void> login({
    required String email,
    required String password,
  })async{
    state = state.copyWith(status: AuthStatus.loading);
    final params = LoginUsecaseParams(email: email, password: password);
    final result = await _loginUsecase(params);

    result.fold((failure){
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message
      );
    }, (authEntity){
      state = state.copyWith(
        status: AuthStatus.authenticated,
        authEntity:authEntity);
      
    });
  }
}