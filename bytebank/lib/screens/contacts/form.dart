import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Novo Contato';
const _rotuloConta = 'Número Conta';
const _rotuloContato = 'Nome Completo';
const _dicaConta = '0000';
const _textoBotaoCriar = 'Salvar';

class ContactForm extends StatefulWidget {
  final ContactDao _dao = ContactDao();
  ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleConta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Editor(
              controlador: _controleNome,
              rotulo: _rotuloContato,
              isTecladoNumerico: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Editor(
                controlador: _controleConta,
                rotulo: _rotuloConta,
                dica: _dicaConta,
                isTecladoNumerico: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String name = _controleNome.text;
                    final int? accountNumber =
                        int.tryParse(_controleConta.text);
                    if (accountNumber != null) {
                      final Contact newContact =
                          Contact(0, name, accountNumber);
                      widget._dao
                          .save(newContact)
                          .then((id) => Navigator.pop(context));
                    }
                  },
                  child: const Text(_textoBotaoCriar),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
