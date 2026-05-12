import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../data/repository/interfaces/i_auth_repository.dart';
import 'i_forgot_password_use_case.dart';

class ForgotPasswordUseCase implements IForgotPasswordUseCase {
  const ForgotPasswordUseCase({required this.authRepository});
  final IAuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({
    required String phone,
  }) async {
    return authRepository.forgotPassword(
      phone: phone,
    );
  }
}
