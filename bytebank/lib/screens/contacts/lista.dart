import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:bytebank/screens/transferencia/transaction_form.dart';
import 'package:flutter/material.dart';

const _textoContato = 'Transferência';
const _textoErrNaoIdentificado =
    'Erro não identificado ao carregar a lista de contatos!';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

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
                return const Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact>? contacts = snapshot.data;
                if (contacts != null) {
                  return ListView.builder(
                    itemBuilder: ((context, index) {
                      final Contact contact = contacts[index];
                      return _ContactItem(
                        contact,
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TransactionForm(contact: contact)));
                        },
                      );
                    }),
                    itemCount: contacts.length,
                  );
                }
                break;
            }
            return const Text(_textoErrNaoIdentificado);
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => ContactForm()),
              )
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem(this.contact, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
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
