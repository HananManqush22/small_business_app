abstract class ApiConsumer {
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? query,
    Object? data,
  });
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic> data,
    bool isFormData = false,
  });
  Future<dynamic> patch({
    required String url,
    Map<String, dynamic>? query,
    Object? data,
    bool isFormData = false,
  });
  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? query,
    Object? data,
    bool isFormData = false,
  });
}
