import 'package:contacts/models/contact_model.dart';
import 'package:flutter/material.dart';

import 'edit_page.dart';

class DetailsPage extends StatefulWidget {
  ContactModel contactModel;

  DetailsPage({super.key, required this.contactModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text('Contato'),
            centerTitle: true),
        body: _body(context),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[200],
          shape: const CircleBorder(),
          child: const Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _goToContactPage(conta: widget.contactModel);
            });
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     return EditPage(model: widget.contactModel);
            //   }),
            // );
          },
        ));
  }

  Future<void> _goToContactPage({ContactModel? conta}) async {
    final retConta = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return EditPage(model: conta);
      }),
    );
    setState(() {
      widget.contactModel = retConta;
    });
  }

  Column _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: double.infinity),
        _image(context),
        _mainData(),
        const SizedBox(height: 20),
        _buttons(),
        _address()
      ],
    );
  }

  Column _mainData() {
    return Column(
      children: [
        Text(
          widget.contactModel.name,
          //'Silvio Agnello',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(widget.contactModel.phone,
            //'41-99203-2486',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        Text(widget.contactModel.email,
            //'silvio.agnello@gmail.com',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic)),
      ],
    );
  }

  _address() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListTile(
        title: const Text('Endereço',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.contactModel.address), //'Rua do desenvolvedor, 250'),
            Text(widget.contactModel.cityUf), //'Piracicabe, SP'),
          ],
        ),
        trailing: const ElevatedButton(
          onPressed: null,
          child: Icon(Icons.pin_drop),
        ),
      ),
    );
  }

  Row _buttons() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(onPressed: null, child: Icon(Icons.phone)),
        ElevatedButton(onPressed: null, child: Icon(Icons.email)),
        ElevatedButton(onPressed: null, child: Icon(Icons.camera_alt)),
      ],
    );
  }

  Container _image(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/images/man.png')),
            borderRadius: BorderRadius.circular(200),
            color: Theme.of(context).primaryColor.withOpacity(0.1)));
  }
}
