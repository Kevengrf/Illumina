import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:flutter_application_illumina/screens/tarefa/formTarefa.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({Key? key}) : super(key: key);

  @override
  State<Tarefas> createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  final now = DateTime.now();
  late DateTime _selectedDate;

  final List<Tarefa> _tarefas = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    Intl.defaultLocale = 'pt_BR';
    _selectedDate = now;
  }

  void _addTarefa(Tarefa tarefa) {
    setState(() {
      _tarefas.add(tarefa);
    });
  }

  List<Tarefa> _tarefasFiltradas() {
    return _tarefas.where((tarefa) {
      return tarefa.data.year == _selectedDate.year &&
          tarefa.data.month == _selectedDate.month &&
          tarefa.data.day == _selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  return Scaffold(
    body: Column(
      children: [
        _cabecalho(context),
        _dateBar(),
        const SizedBox(height: 50),
        Expanded(
          child: _tarefasFiltradas().isEmpty
              ? const Center(
                  child: Text(
                    "Nenhuma tarefa para hoje.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : ListView(
                  children: _tarefasFiltradas().map((tarefa) {
                    return ListTile(
                      title: Text(
                        tarefa.titulo,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text(
                        tarefa.nota,
                        style: const TextStyle(
                            color: Color.fromRGBO(145, 156, 174, 1),
                            fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    ),
  );
}


  _cabecalho(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          title: const Text(
            "Hoje",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Text(
            DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR').format(now),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 214, 213, 213),
            ),
          ),
          trailing: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(Color.fromRGBO(255, 234, 0, 1)),
            ),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Add Tarefa',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              final tarefa = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormTarefa(),
                ),
              );

              if (tarefa != null) {
                _addTarefa(tarefa);
              }
            },
          ),
        ),
      ),
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: _selectedDate,
        selectionColor: const Color.fromRGBO(145, 156, 174, 1),
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
        monthTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dateTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: const TextStyle(fontSize: 0),
        locale: 'pt',
      ),
    );
  }
}
