import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:equatable/equatable.dart';

class RefreshTokenResponseEntity extends Equatable implements Entity {
  const RefreshTokenResponseEntity({
    required this.accessToken,
    required this.expiresIn,
  });

  final String accessToken;
  final int expiresIn;

  @override
  List<Object?> get props => [accessToken, expiresIn];

  @override
  RefreshTokenResponseEntity copyWith({String? accessToken, int? expiresIn}) =>
      RefreshTokenResponseEntity(
        accessToken: accessToken ?? this.accessToken,
        expiresIn: expiresIn ?? this.expiresIn,
      );
}
