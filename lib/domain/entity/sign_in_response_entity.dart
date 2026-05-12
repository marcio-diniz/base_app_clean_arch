import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:equatable/equatable.dart';

class SignInResponseEntity extends Equatable implements Entity {
  const SignInResponseEntity({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  final String userId;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  @override
  List<Object?> get props => [userId, accessToken, refreshToken, expiresIn];

  @override
  SignInResponseEntity copyWith({
    String? userId,
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) => SignInResponseEntity(
    userId: userId ?? this.userId,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    expiresIn: expiresIn ?? this.expiresIn,
  );
}
