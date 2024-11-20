import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TarefaData {

  Future<List<Tarefa>> getAllTarefa() async {
    QueryBuilder<ParseObject> queryTarefas =
        QueryBuilder<ParseObject>(ParseObject('Tarefa'))
          ..orderByDescending("createdAt");

    final ParseResponse parseResponse = await queryTarefas.query();

    if (parseResponse.success && parseResponse.results != null) {
      return parseResponse.results!
          .map((e) => Tarefa(
                id: (e as ParseObject).objectId,
                titulo: e.get<String>('titulo'),
                nota: e.get<String>('nota'),
                data: e.get<DateTime>('data'),
                concluido: e.get<bool>('concluido') ?? false,
              ))
          .toList();
    }
    return [];
  }

  Future<bool> addTarefa(Tarefa tarefa) async {
    final parseObject = ParseObject('Tarefa')
      ..set('titulo', tarefa.titulo)
      ..set('nota', tarefa.nota)
      ..set('data', tarefa.data)
      ..set('concluido', tarefa.concluido);

    final ParseResponse response = await parseObject.save();
    return response.success;
  }

  Future<bool> updateTarefa(Tarefa tarefa) async {
    final parseObject = ParseObject('Tarefa')
      ..objectId = tarefa.id
      ..set('titulo', tarefa.titulo)
      ..set('nota', tarefa.nota)
      ..set('data', tarefa.data)
      ..set('concluido', tarefa.concluido);

    final ParseResponse response = await parseObject.save();
    return response.success;
  }

  Future<bool> deleteTarefa(String id) async {
    final parseObject = ParseObject('Tarefa')..objectId = id;
    final ParseResponse response = await parseObject.delete();
    return response.success;
  }
}

