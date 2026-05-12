import 'package:equatable/equatable.dart';

import 'model.dart';

class RefreshTokenResponseModel extends Equatable implements Model {
  const RefreshTokenResponseModel({
    required this.accessToken,
    required this.expiresIn,
  });

  final String accessToken;
  final int expiresIn;

  @override
  List<Object?> get props => [accessToken, expiresIn];

  @override
  factory RefreshTokenResponseModel.fromMap(Map<String, dynamic> data) =>
      RefreshTokenResponseModel(
        accessToken: data['access_token'] as String,
        expiresIn: data['expires_in'] as int,
      );

  static RefreshTokenResponseModel? maybeFromMap(dynamic data) => data is Map
      ? RefreshTokenResponseModel.fromMap(data.cast<String, dynamic>())
      : null;

  @override
  Map<String, dynamic> toMap() => {
    'access_token': accessToken,
    'expires_in': expiresIn,
  };

  @override
  String toString() => 'EventStruct(${toMap()})';
}
