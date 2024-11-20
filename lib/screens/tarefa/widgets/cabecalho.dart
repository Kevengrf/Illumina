import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_illumina/screens/tarefa/formTarefa.dart';

Widget Cabecalho(BuildContext context, DateTime now, Function atualizarTarefas) {
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
                WidgetStateProperty.all(const Color.fromRGBO(255, 234, 0, 1)),
          ),
          icon: const Icon(Icons.add, color: Colors.black),
          label: const Text(
            'Add Tarefa',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            final tarefaAdicionada = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FormTarefa(),
              ),
            );
            if (tarefaAdicionada == true) {
              atualizarTarefas();
            }
          },
        ),
      ),
    ),
  );
}
