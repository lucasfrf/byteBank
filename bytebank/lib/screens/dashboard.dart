import 'package:bytebank/screens/contacts/lista.dart';
import 'package:bytebank/screens/transferencia/transactions_list.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Dashboard';
const _textoTrasnferencia = 'Transferencia';
const _textoTrasnferenciaFeed = 'Feed Transferencia';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Theme.of(context).primaryColorDark,
          title: const Text(_tituloAppBar),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/bytebank_logo.png'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FeatureItem(
                    _textoTrasnferencia,
                    Icons.monetization_on,
                    onClick: () => _showContactsList(context),
                  ),
                  _FeatureItem(
                    _textoTrasnferenciaFeed,
                    Icons.description,
                    onClick: () => _showTransactionsList(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showContactsList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ContactsList()));
}

void _showTransactionsList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const TransactionsList()));
}
