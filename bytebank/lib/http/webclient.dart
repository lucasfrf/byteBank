import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (kDebugMode) {
      debugPrint('Request');
      debugPrint('url: ${data.url}');
      debugPrint('headers: ${data.headers}');
      debugPrint('body: ${data.body}');
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (kDebugMode) {
      debugPrint('Response');
      debugPrint('status code: ${data.statusCode}');
      debugPrint('headers: ${data.headers}');
      debugPrint('body: ${data.body}');
    }
    return data;
  }
}

Future<void> findAll() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get(Uri.http('172.24.160.1:8080', 'transactions'));
  if (kDebugMode) {
    print(response.body);
  }
}
