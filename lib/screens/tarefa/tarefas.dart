import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:flutter_application_illumina/screens/tarefa/formTarefa.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _adicionarTarefa(Tarefa tarefa) {
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
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: ListView(
        children: [
          _addTarefa(context),
          _dateBar(width),
          _tarefasFiltradas().isEmpty
              ? const Center(child: Text("Nenhuma tarefa para hoje."))
              : Column(
                  children: _tarefasFiltradas().map((tarefa) {
                    return ListTile(
                      title: Text(tarefa.titulo),
                      subtitle: Text(tarefa.nota),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _addTarefa(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        elevation: 0,
        child: ListTile(
          title: const Text(
            "Hoje",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR').format(now),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Tarefa'),
            onPressed: () async {
              final tarefa = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormTarefa(),
                ),
              );

              if (tarefa != null) {
                _adicionarTarefa(tarefa);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _dateBar(double width) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: _selectedDate,
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: const TextStyle(fontSize: 0),
        locale: 'pt',
      ),
    );
  }
}
