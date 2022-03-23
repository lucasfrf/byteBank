import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferência';

class ListaTrasferecias extends StatefulWidget {
  final List<Transferencia> _transferencias = List.empty(growable: true);
  ListaTrasferecias({Key? key}) : super(key: key);

  @override
  State<ListaTrasferecias> createState() => _ListaTrasfereciasState();
}

class _ListaTrasfereciasState extends State<ListaTrasferecias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(_tituloAppBar)),
        body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferecias(transferencia: transferencia);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const FormularioTransferencia();
            })).then(
                (transferenciaRecebida) => _atualiza(transferenciaRecebida));
          },
          child: const Icon(Icons.add),
        ));
  }

  void _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTransferecias extends StatelessWidget {
  final Transferencia transferencia;

  const ItemTransferecias({Key? key, required this.transferencia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(transferencia.valor.toString()),
      subtitle: Text(transferencia.numeroConta.toString()),
    ));
  }
}
