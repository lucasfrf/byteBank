import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String _baseUrl = '172.24.160.1:8080';
const String _recursoTransacao = 'transactions';
final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

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

Future<List<Transaction>>? findAll() async {
  final Response response = await client
      .get(Uri.http(_baseUrl, _recursoTransacao))
      .timeout(const Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ));
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };

  final transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(
    Uri.http(_baseUrl, _recursoTransacao),
    headers: {'Content-type': 'application/json', 'password': '1000'},
    body: transactionJson,
  );

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ));
}
