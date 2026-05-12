import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IRegisterUserUseCase {
  Future<Either<Failure, void>> call({
    required String phone,
    required String password,
    required int termsVersion,
    required int privacyPolicyVersion,
  });
}
