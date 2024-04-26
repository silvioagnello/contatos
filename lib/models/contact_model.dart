class ContactModel {
  String? id;
  String name;
  String phone;
  String email;
  String address;
  String cityUf;

  ContactModel(
      {this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.address,
      required this.cityUf});

  factory ContactModel.fromSQLite(Map map) {
    return ContactModel(
        id: map['id'].toString(),
        name: map['name'],
        phone: map['phone'],
        email: map['email'],
        address: map['address'],
        cityUf: map['cityUf']);
  }

  static List<ContactModel> fromSQLiteList(List<Map> listMap) {
    List<ContactModel> contatos = [];
    for (Map item in listMap) {
      contatos.add(ContactModel.fromSQLite(item));
    }
    return contatos;
  }

  factory ContactModel.empty() {
    return ContactModel(
        name: '', phone: '', email: '', address: '', cityUf: '');
  }

  @override
  String toString() {
    return 'Contato: $id, $name, $phone, $email, $address, $cityUf';
  }
}
