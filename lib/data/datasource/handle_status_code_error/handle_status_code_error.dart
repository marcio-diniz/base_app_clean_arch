import 'package:base_app_clean_arch/core/error/exceptions.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/i_handle_status_code_error.dart';

class HandleStatusCodeError implements IHandleStatusCodeError {
  const HandleStatusCodeError();

  @override
  Future<Exception?> hasException({required int? statusCode}) async {
    if (statusCode == 500) {
      return ServerException();
    }
    if (statusCode == 401) {
      return UnauthorizedException();
    }
    if (statusCode == 409) {
      return ConflictException();
    }
    if (statusCode == 404) {
      return NotFoundException();
    }
    if (statusCode == 423) {
      return NoVehicleConnectionException();
    }
    if (statusCode != 200 && statusCode != 201) {
      return Exception();
    }
    return null;
  }
}
