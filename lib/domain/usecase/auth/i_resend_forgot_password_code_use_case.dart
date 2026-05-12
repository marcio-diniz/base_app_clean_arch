import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../enums/send_code_type_enum.dart';

abstract class IResendForgotPasswordCodeUseCase {
  Future<Either<Failure, void>> call({
    required String? phone,
    required SendCodeTypeEnum sendCodeType,
  });
}
