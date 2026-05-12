abstract class IHandleStatusCodeError {
  Future<Exception?> hasException({required int? statusCode});
}
