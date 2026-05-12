import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repository/i_auth_repository.dart';
import 'i_change_password_use_case.dart';

class ChangePasswordUseCase implements IChangePasswordUseCase {
  const ChangePasswordUseCase({required this.authRepository});
  final IAuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({
    required String phone,
    required String password,
    required String confirmationCode,
  }) async {
    return authRepository.changePassword(
      phone: phone,
      password: password,
      confirmationCode: confirmationCode,
    );
  }
}
