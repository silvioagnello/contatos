import 'package:contacts/models/contact_model.dart';

class ConnectionSQL {
  static const CREATE_DATABASE = '''
  CREATE TABLE "contatos" (
    id	INTEGER PRIMARY KEY AUTOINCREMENT,
    name	TEXT,
    phone	TEXT,
    email TEXT,
    address TEXT,
    cityUf TEXT
  );
  ''';

  static String selecionarTodosOsContatos() {
    return 'select * from contatos;';
  }

  static String adicionarContato(ContactModel contato) {
    return '''
    INSERT INTO contatos (name, phone, email, address, cityUf)
    values (${contato.name}, ${contato.phone}, ${contato.email}, ${contato.address}, ${contato.cityUf});
    ''';
  }

  static String atualizarContato(ContactModel contato) {
    return '''
    update contatos
    set name = ${contato.name},
    phone = ${contato.phone},
    email = ${contato.email},
    address = ${contato.address},
    cityUf = ${contato.cityUf}  
    where id = ${contato.id};
    ''';
  }

  static String deletarContato(ContactModel contato) {
    return 'delete from contatos where id = ${contato.id};';
  }
}
