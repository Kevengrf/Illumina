import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:flutter_application_illumina/data/TarefaData.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TarefaService {
  final TarefaData _tarefaRepository;

  TarefaService() : _tarefaRepository = TarefaData();

  Future<List<Tarefa>> getAllTarefas() {
    return _tarefaRepository.getAllTarefa();
  }

  Future<bool> adicionarTarefa(Tarefa tarefa) async {
    try {
      await _tarefaRepository.addTarefa(tarefa);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> atualizarTarefa(Tarefa tarefa) {
    return _tarefaRepository.updateTarefa(tarefa);
  }

  Future<bool> excluirTarefa(String id) async {
    try {
      final parseObject = ParseObject('Tarefa')..objectId = id;
      final response = await parseObject.delete();
      return response.success;
    } catch (e) {
      return false;
    }
  }
}
