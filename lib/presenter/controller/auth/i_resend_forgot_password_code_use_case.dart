import 'package:base_app_clean_arch/domain/enums/send_code_type_enum.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IResendForgotPasswordCodeUseCase {
  Future<Either<Failure, void>> call({
    required String? phone,
    required SendCodeTypeEnum sendCodeType,
  });
}
