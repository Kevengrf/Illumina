import 'package:flutter_application_illumina/dtos/UsuarioLoginDTO.dart';
import 'package:flutter_application_illumina/models/Usuario.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../dtos/UsuarioCadastroDTO.dart';

class UsuarioData {
  Future<Usuario?> getLastUsuario() async {
    QueryBuilder<ParseObject> queryUsuarios =
        QueryBuilder<ParseObject>(ParseObject('Usuario'))
          ..orderByDescending("createdAt")
          ..setLimit(1);

    final ParseResponse parseResponse = await queryUsuarios.query();

    if (parseResponse.success && parseResponse.results != null) {
      final ParseObject usuarioObj =
          parseResponse.results!.first as ParseObject;
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

  Future<bool> login(UsuarioLoginDTO usuarioDTO) async {
    QueryBuilder<ParseObject> queryUsuarios =
        QueryBuilder<ParseObject>(ParseObject('Usuario'))
          ..whereEqualTo('Nome', usuarioDTO.nome)
          ..whereEqualTo('Senha', usuarioDTO.senha);

    final ParseResponse parseResponse = await queryUsuarios.query();

    return parseResponse.success && parseResponse.results != null;
  }

  Future<bool> cadastro(UsuarioCadastroDTO usuarioDTO) async{
    final parseObject = ParseObject('Usuario')
      ..set('Nome', usuarioDTO.nome)
      ..set('Email', usuarioDTO.email)
      ..set('Senha', usuarioDTO.senha);
    final ParseResponse response = await parseObject.save();
    return response.success;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuario'); // Exemplo: removendo os dados do usuário
    await prefs.remove('token');   // Caso tenha um token de autenticação
  }
}
