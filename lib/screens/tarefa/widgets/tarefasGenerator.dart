import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/repository/TarefaRepository.dart';

class TarefasGenerator extends StatefulWidget {
  const TarefasGenerator({super.key});

  @override
  State<TarefasGenerator> createState() => _TarefasGeneratorState();
}

class _TarefasGeneratorState extends State<TarefasGenerator> {
  late Future<List<Map<String, dynamic>>> _tarefas;

  @override
  void initState() {
    super.initState();
    _tarefas = TarefaRepository().getAllTarefa(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _tarefas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa encontrada.'));
          }

          List<Map<String, dynamic>> tarefas = snapshot.data!;
          return ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = tarefas[index];
              return ListTile(
                title: Text(tarefa['titulo'] ?? 'Sem título'),
                subtitle: Text(tarefa['nota'] ?? 'Sem nota'),
                trailing: Text(tarefa['data'] ?? 'Sem data'),
              );
            },
          );
        },
      ),
    );
  }
}
