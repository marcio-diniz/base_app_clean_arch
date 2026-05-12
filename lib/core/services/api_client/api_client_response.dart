class ApiClientResponse<T> {
  ApiClientResponse({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final T? data;
}
