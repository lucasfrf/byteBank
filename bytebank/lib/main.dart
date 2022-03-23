import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'http/webclient.dart';

void main() {
  runApp(const ByteBankApp());
  findAll();
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: const Dashboard());
  }
}
