import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repository/i_auth_repository.dart';
import 'i_sign_out_use_case.dart';

class SignOutUseCase implements ISignOutUseCase {
  const SignOutUseCase({required this.authRepository});
  final IAuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call() async {
    return authRepository.signOut();
  }
}
