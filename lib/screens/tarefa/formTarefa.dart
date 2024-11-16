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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Adicionar Tarefa',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controladorTitulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controladorNota,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
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
                    _controladorData.text =
                        DateFormat('dd/MM/yyyy').format(selecionarData);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _controladorData,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 234, 0, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    final String titulo = _controladorTitulo.text;
                    final String nota = _controladorNota.text;
                    final DateTime data = selecionarData;

                    Tarefa novaTarefa = Tarefa(titulo, nota, data);

                    Navigator.pop(context, novaTarefa);
                  },
                  child: const Text(
                    'Adicionar Tarefa',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
