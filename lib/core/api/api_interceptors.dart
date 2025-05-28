import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    options.headers.addAll({
      'Authorization': 'Bearer ${idToken.toString()}',
      'Accept': 'application/json',
    });

    super.onRequest(options, handler);
  }
}
