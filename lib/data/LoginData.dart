import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginData {
  Future<bool> login(String email, String senha) async {
    QueryBuilder<ParseObject> queryUsuarios =
        QueryBuilder<ParseObject>(ParseObject('Usuario'))
          ..whereEqualTo('Nome', email)
          ..whereEqualTo('Senha', senha);

    final ParseResponse parseResponse = await queryUsuarios.query();

    return parseResponse.success && parseResponse.results != null;
  }
}
