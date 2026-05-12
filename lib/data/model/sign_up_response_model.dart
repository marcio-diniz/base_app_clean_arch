import 'package:equatable/equatable.dart';

import 'model.dart';

class SignUpResponseModel extends Equatable implements Model {
  const SignUpResponseModel({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];

  @override
  factory SignUpResponseModel.fromMap(Map<String, dynamic> data) =>
      SignUpResponseModel(userId: data['UserSub'] as String);

  static SignUpResponseModel? maybeFromMap(dynamic data) => data is Map
      ? SignUpResponseModel.fromMap(data.cast<String, dynamic>())
      : null;

  @override
  Map<String, dynamic> toMap() => {'UserSub': userId};

  @override
  String toString() => 'EventStruct(${toMap()})';
}
