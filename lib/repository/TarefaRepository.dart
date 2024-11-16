import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<List<Map<String, dynamic>>> getAllTarefa() async {
    late List<Map<String, dynamic>> result = [];
    QueryBuilder<ParseObject> queryUsers =
        QueryBuilder<ParseObject>(ParseObject('Tarefa'))
          ..orderByDescending("createdAt");

    final ParseResponse parseResponse = await queryUsers.query();

    if (parseResponse.success && parseResponse.results != null) {
      final tarefa = parseResponse.results!;

      for (var element in tarefa) {
        result.add({
          'titulo': element.get<String>('titulo'),
          'nota': element.get<String>('nota'),
          'data': element.get<DateTime>('data').toString()
        });
      }
    }
    return result;
  }

  void addTarefa(Tarefa tarefa) async {
    var parseObject = ParseObject('Tarefa')
      ..set('titulo', tarefa.titulo)
      ..set('nota', tarefa.nota)
      ..set('data', tarefa.data);
    final ParseResponse parseResponse = await parseObject.save();
    if (parseResponse.success) {
      var objectId = (parseResponse.results!.first as ParseObject).objectId!;
      print('Object created: $objectId');
    } else {
      print('Object created with failed: \${parseResponse.error.toString()}');
    }
  }
}
