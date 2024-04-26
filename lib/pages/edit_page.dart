import 'package:contacts/models/contact_model.dart';
import 'package:flutter/material.dart';

import '../repositories/contato_dao.dart';

class EditPage extends StatefulWidget {
  final ContactModel? model;

  const EditPage({super.key, this.model});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  ContactModel contactModel = ContactModel.empty();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityUfController = TextEditingController();
  final ContatoDAO _contatoDAO = ContatoDAO();

  @override
  void initState() {
    super.initState();
    if (widget.model?.id != null) {
      contactModel = widget.model!;
    }
    _addressController.text = contactModel.address;
    _cityUfController.text = contactModel.cityUf;
    _emailController.text = contactModel.email;
    _phoneController.text = contactModel.phone;
    _nameController.text = contactModel.name;
  }

  void _save() {
    contactModel.email = _emailController.text;
    contactModel.phone = _phoneController.text;
    contactModel.name = _nameController.text;
    contactModel.cityUf = _cityUfController.text;
    contactModel.address = _addressController.text;

    if (contactModel.id == '' || contactModel.id == null) {
      _contatoDAO.adicionar(contactModel);
      return;
    }
    _contatoDAO.alterar(contactModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: contactModel.id == null
            ? const Text('Novo contato')
            : Text(contactModel.name),
        centerTitle: true,
      ),
      body: _form(),
    );
  }

  SingleChildScrollView _form() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
              child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dados principais',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                labelText: 'Nome do contato')),
                        TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                labelText: 'Email do contato')),
                        TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                                labelText: 'Telefone do contato')),
                        const SizedBox(height: 30),
                        const Text('Endereço',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                            controller: _addressController,
                            decoration:
                                const InputDecoration(labelText: 'Endereço')),
                        TextFormField(
                            controller: _cityUfController,
                            decoration: const InputDecoration(
                                labelText: 'Cidade/Estado')),
                      ]))),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  _save();
                  Navigator.pop(context, contactModel);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
