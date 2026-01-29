import 'package:equatable/equatable.dart';
import 'package:match_aura/features/auth/domain/entities/auth_entity.dart';

enum AuthStatus { initial, loading,authenticated,unauthenticated,registered, error }

class AuthState extends Equatable{
  final AuthStatus status;
  final AuthEntity? authEntity;
  final String? errorMessage;
  final String? uploadImageName;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authEntity,
    this.errorMessage, this.uploadImageName,
});

  // copywith function
  AuthState copyWith({
    AuthStatus? status,
    AuthEntity? authEntity,
    String? errorMessage,
    String? uploadImageName,  String? uploadedPhotoUrl,
  }) {
    return AuthState(
        status: status ?? this.status,
        authEntity: authEntity ?? this.authEntity,
        errorMessage: errorMessage ?? this.errorMessage,
        uploadImageName: uploadImageName ?? this.uploadImageName,

    );
  }


  @override
  List<Object?> get props => [status, authEntity, errorMessage,uploadImageName];

}