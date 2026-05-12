abstract class Model {
  factory Model.fromMap(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap();
}
