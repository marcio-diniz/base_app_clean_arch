import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:equatable/equatable.dart';

class SignUpResponseEntity extends Equatable implements Entity {
  const SignUpResponseEntity({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];

  @override
  SignUpResponseEntity copyWith({String? userId}) =>
      SignUpResponseEntity(userId: userId ?? this.userId);
}
