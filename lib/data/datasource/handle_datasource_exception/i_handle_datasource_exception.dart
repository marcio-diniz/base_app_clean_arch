abstract class IHandleDatasourceException {
  Future<T> call<T>(
    Future<T> Function() request, {
    bool redirectToLoginOnFail = true,
  });
}
