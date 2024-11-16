import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:flutter_application_illumina/repository/TarefaRepository.dart';

class TarefaService {
  final TarefaRepository _tarefaRepository;

  TarefaService() : _tarefaRepository = TarefaRepository();

  void adicionarTarefa(Tarefa tarefa) {
    if (tarefa.titulo.isNotEmpty) {
      _tarefaRepository.addTarefa(tarefa);
    }
  }
}
