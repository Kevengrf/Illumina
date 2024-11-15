import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/models/Tarefa.dart';
import 'package:intl/intl.dart';

class FormTarefa extends StatefulWidget {
  const FormTarefa({super.key});

  @override
  _FormTarefaState createState() => _FormTarefaState();
}

class _FormTarefaState extends State<FormTarefa> {
  final TextEditingController _controladorTitulo = TextEditingController();
  final TextEditingController _controladorNota = TextEditingController();
  final TextEditingController _controladorData = TextEditingController();

  DateTime selecionarData = DateTime.now();

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controladorTitulo,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _controladorNota,
              decoration: const InputDecoration(labelText: 'Nota'),
            ),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selecionarData,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                  locale: const Locale('pt', 'BR'),
                );
                if (pickedDate != null && pickedDate != selecionarData) {
                  setState(() {
                    selecionarData = pickedDate;
                    _controladorData.text = DateFormat('dd/MM/yyyy').format(selecionarData);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _controladorData,
                  decoration: const InputDecoration(labelText: 'Data'),
                ),
              ),
            ),
            TextButton(
              child: const Text('Cadastrar'),
              onPressed: () {
                final String titulo = _controladorTitulo.text;
                final String nota = _controladorNota.text;
                final DateTime data = selecionarData;

                Tarefa novaTarefa = Tarefa(titulo, nota, data);

                Navigator.pop(context, novaTarefa);  // Retorna a nova tarefa
              },
            ),
          ],
        ),
      ),
    );
  }
}
