import 'package:flutter_application_illumina/models/Usuario.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UsuarioData {

  Future<Usuario?> getLastUsuario() async {
  QueryBuilder<ParseObject> queryUsuarios =
      QueryBuilder<ParseObject>(ParseObject('Usuario'))
        ..orderByDescending("createdAt")
        ..setLimit(1);

  final ParseResponse parseResponse = await queryUsuarios.query();

  if (parseResponse.success && parseResponse.results != null) {
    final ParseObject usuarioObj = parseResponse.results!.first as ParseObject;
    return Usuario(
      id: usuarioObj.objectId,
      nome: usuarioObj.get<String>('Nome'),
      email: usuarioObj.get<String>('Email'),
      senha: usuarioObj.get<String>('Senha'),
    );
  }

  
  return null;
}

  Future<bool> updateUsuario(Usuario usuario) async {
    final parseObject = ParseObject('Usuario')
      ..objectId = usuario.id
      ..set('Nome', usuario.nome)
      ..set('Email', usuario.email)
      ..set('Senha', usuario.senha);
    final ParseResponse response = await parseObject.save();
    return response.success;
  }

}

