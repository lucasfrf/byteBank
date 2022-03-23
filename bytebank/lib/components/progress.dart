import 'package:flutter/material.dart';

const _textoCarregando = 'Carregando';

class Progress extends StatelessWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [CircularProgressIndicator(), Text(_textoCarregando)],
      ),
    );
  }
}
