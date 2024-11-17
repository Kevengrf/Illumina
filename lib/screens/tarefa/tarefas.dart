import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:flutter_application_illumina/screens/tarefa/widgets/cabecalho.dart';
import 'package:flutter_application_illumina/screens/tarefa/widgets/carrosselDatas.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_application_illumina/repository/TarefaRepository.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  State<Tarefas> createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  final now = DateTime.now();
  late DateTime _selectedDate;
  late Future<List<Map<String, dynamic>>> _tarefasFuture;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    Intl.defaultLocale = 'pt_BR';
    _selectedDate = now;
    _tarefasFuture = TarefaRepository().getAllTarefa(); 
  }

  List<Map<String, dynamic>> _tarefasFiltradas(List<Map<String, dynamic>> tarefas) {
    return tarefas.where((tarefa) {
      DateTime tarefaData = DateTime.parse(tarefa['data']);
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
          Cabecalho(context, now),
          CarrosselDatas(_selectedDate, (date) {
            setState(() {
              _selectedDate = date;
            });
          }),
          const SizedBox(height: 50),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
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

                List<Map<String, dynamic>> tarefasFiltradas = _tarefasFiltradas(snapshot.data!);

                return ListView(
                  children: tarefasFiltradas.map((tarefa) {
                    return ListTile(
                      title: Text(
                        tarefa['titulo'],
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text(
                        tarefa['nota'],
                        style: const TextStyle(color: Color.fromRGBO(145, 156, 174, 1), fontSize: 14),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
