import 'package:contacts/repositories/contato_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../commons/message_snack.dart';
import '../models/contact_model.dart';
import 'details_page.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Mensagens messages = Mensagens();
  final ContatoDAO _contatoDAO = ContatoDAO();
  List<ContactModel> contacts = [];

  delete(cont, ContactModel c) async {
    try {
      if (await _contatoDAO.deletar(c)) {
        String msg = 'Eliminado com sucesso';
        messages.messageSnack(cont, msg);
        // Navigator.pop(cont);
      }
    } on Exception catch (e) {
      messages.messageSnack(cont, e.toString());
    }
    getAllContacts(cont);
  }

  getAllContacts(c) async {
    //SELECIONARTODOSCONTATOS - DAO
    try {
      // setState(() {
      // });
      List<ContactModel> retorno = await _contatoDAO.selecionarTodos();
      contacts.clear();
      contacts.addAll(retorno);
    } on Exception catch (e) {
      messages.messageSnack(c, e);
    }
    if (contacts.isEmpty) {
      contacts.add(ContactModel(
          id: '0',
          name: 'teste1',
          phone: '11 1111-1111',
          email: 'teste@teste.com',
          address: 'rua teste 234',
          cityUf: 'SAO PAUL}O - SP'));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllContacts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Contatos'),
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))),
        actions: [
          IconButton(
              onPressed: () async {
                if (kIsWeb) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: Icon(Icons.exit_to_app, color: Colors.blueAccent)))
        ],
      ),
      body: _listContacts(),
      floatingActionButton: createButton(context),
    );
  }

  FloatingActionButton createButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue[200],
      shape: const CircleBorder(),
      tooltip: 'Criar',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditPage()),
        ).then((value) => getAllContacts(context));
      },
      child: const Icon(Icons.create_outlined),
    );
  }

  ListView _listContacts() {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          ContactModel contato = contacts[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              dense: false,
              leading: Image.asset('assets/images/man.png'),
              isThreeLine: true,
              title: Text(contato.name),
              subtitle: Text(contato.phone),
              trailing: Container(
                color: Colors.transparent,
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.delete, color: Colors.cyan),
                        onPressed: () {
                          print('delete');
                          delete(context, contato)
                              .then((value) => getAllContacts(context));
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(contactModel: contato),
                                )).then((value) => getAllContacts(context));
                          },
                          icon: const Icon(Icons.chat, color: Colors.cyan)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
