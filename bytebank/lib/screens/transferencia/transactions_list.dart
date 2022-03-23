import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

const _textoErroDesconhecido = 'Erro desconhecido';
const _textoTransactionsNotFound = 'Não foi encontrada nenhuma transação';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return const Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction>? transactions = snapshot.data;
                  if (transactions != null) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                }
                return const CenteredMessage(
                  message: _textoTransactionsNotFound,
                  icon: Icons.warning,
                );
            }
            return const CenteredMessage(
              message: _textoErroDesconhecido,
            );
          }),
    );
  }
}
