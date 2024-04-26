import 'package:contacts/repositories/sql.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact_model.dart';
import 'connection_sqlite_service.dart';

class ContatoDAO {
  final ConnectionSQLiteService _connection = ConnectionSQLiteService.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<ContactModel> adicionar(ContactModel contato) async {
    try {
      Database db = await _getDatabase();
      int id = await db.rawInsert(ConnectionSQL.adicionarContato(contato));
      contato.id = id.toString();
      return contato;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> alterar(ContactModel contato) async {
    try {
      Database db = await _getDatabase();
      int linhasAfetadas =
          await db.rawUpdate(ConnectionSQL.atualizarContato(contato));

      return linhasAfetadas > 0 ? true : false;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> atualizar(ContactModel contato) async {
    try {
      Database db = await _getDatabase();
      int linhasAfetadas =
          await db.rawUpdate(ConnectionSQL.atualizarContato(contato));
      if (linhasAfetadas > 0) {
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }

  Future<List<ContactModel>> selecionarTodos() async {
    try {
      Database db = await _getDatabase();
      List<Map> linhas =
          await db.rawQuery(ConnectionSQL.selecionarTodosOsContatos());
      List<ContactModel> contatos = ContactModel.fromSQLiteList(linhas);
      return contatos;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> deletar(ContactModel contato) async {
    try {
      Database db = await _getDatabase();
      int linhasAfetadas =
          await db.rawUpdate(ConnectionSQL.deletarContato(contato));
      if (linhasAfetadas > 0) {
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }
}
