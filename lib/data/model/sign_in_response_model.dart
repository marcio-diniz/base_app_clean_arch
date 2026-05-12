import 'package:equatable/equatable.dart';

import 'model.dart';

class SignInResponseModel extends Equatable implements Model {
  const SignInResponseModel({
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
  factory SignInResponseModel.fromMap(Map<String, dynamic> data) =>
      SignInResponseModel(
        userId: data['user_id'] as String,
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
        expiresIn: data['expires_in'] as int,
      );

  static SignInResponseModel? maybeFromMap(dynamic data) => data is Map
      ? SignInResponseModel.fromMap(data.cast<String, dynamic>())
      : null;

  @override
  Map<String, dynamic> toMap() => {
    'user_id': userId,
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'expires_in': expiresIn,
  };

  @override
  String toString() => 'EventStruct(${toMap()})';
}
