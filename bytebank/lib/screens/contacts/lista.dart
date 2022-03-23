import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:flutter/material.dart';

const _textoContato = 'Contato';
const _textoCarregando = 'Carregando';
const _textoErrNaoIdentificado =
    'Erro não identificado ao carregar a lista de contatos!';

class ContactsList extends StatelessWidget {
  final ContactDao _dao = ContactDao();
  ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_textoContato)),
      body: FutureBuilder<List<Contact>>(
          initialData: List.empty(growable: false),
          future: _dao.findAll(),
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text(_textoCarregando)
                    ],
                  ),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact>? contacts = snapshot.data;
                if (contacts != null) {
                  return ListView.builder(
                    itemBuilder: ((context, index) {
                      final Contact contact = contacts[index];
                      return _ContactItem(contact);
                    }),
                    itemCount: contacts.length,
                  );
                }
              //break;
            }
            return const Text(_textoErrNaoIdentificado);
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
