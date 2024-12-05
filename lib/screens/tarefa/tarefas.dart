import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/data/TarefaData.dart';
import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:flutter_application_illumina/screens/tarefa/widgets/cabecalho.dart';
import 'package:flutter_application_illumina/screens/tarefa/widgets/carrosselDatas.dart';
import 'package:flutter_application_illumina/service/TarefaService.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  State<Tarefas> createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  final now = DateTime.now();
  late DateTime _selectedDate;
  late Future<List<Tarefa>> _tarefasFuture;

  final TarefaService _tarefaService = TarefaService();

  @override
  void initState() {
    super.initState();
    _selectedDate = now;
    _carregarTarefas();
  }

  void _carregarTarefas() {
    setState(() {
      _tarefasFuture = _tarefaService.getAllTarefas();
    });
  }

  void _atualizarTarefas() {
    setState(() {
      _tarefasFuture = TarefaData().getAllTarefa();
    });
  }

  List<Tarefa> _tarefasFiltradas(List<Tarefa> tarefas) {
    return tarefas.where((tarefa) {
      final tarefaData = tarefa.data;
      if (tarefaData == null) return false;
      return tarefaData.year == _selectedDate.year &&
          tarefaData.month == _selectedDate.month &&
          tarefaData.day == _selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Cabecalho(context, now, _atualizarTarefas),
          CarrosselDatas(_selectedDate, (date) {
            setState(() {
              _selectedDate = date;
            });
          }),
          const SizedBox(height: 50),
          Expanded(
            child: FutureBuilder<List<Tarefa>>(
              future: _tarefasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhuma tarefa para hoje.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                final tarefasFiltradas = _tarefasFiltradas(snapshot.data!);

                return ListView.builder(
                  itemCount: tarefasFiltradas.length,
                  itemBuilder: (context, index) {
                    final tarefa = tarefasFiltradas[index];
                    return ListTile(
                      leading: Checkbox(
                        fillColor: WidgetStateProperty.all(
                            const Color.fromARGB(41, 50, 62, 1)),
                        checkColor: const Color.fromARGB(255, 7, 255, 61),
                        value: tarefa.concluido,
                        onChanged: (bool? newValue) {
                          setState(() {
                            tarefa.concluido = newValue ?? false;
                          });
                          _tarefaService.atualizarTarefa(tarefa);
                        },
                      ),
                      title: Text(
                        tarefa.titulo ?? "Título vazio",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text(
                        tarefa.nota ?? "Nota vazia",
                        style: const TextStyle(
                            color: Color.fromRGBO(145, 156, 174, 1),
                            fontSize: 14),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          _exibirMenuTarefa(context, tarefa);
                        },
                        icon: const Icon(Icons.more_vert),
                        style: IconButton.styleFrom(
                            foregroundColor:
                                const Color.fromRGBO(145, 156, 174, 1)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _exibirMenuTarefa(BuildContext context, Tarefa tarefa) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Excluir'),
              onTap: () {
                Navigator.pop(context);
                _tarefaService.excluirTarefa(tarefa.id!).then((success) {
                  if (success) {
                    _carregarTarefas();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erro ao excluir a tarefa')),
                    );
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
