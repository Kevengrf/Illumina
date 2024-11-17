import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/screens/agenda/Agenda.dart';
import 'package:flutter_application_illumina/screens/login/Login.dart';
import 'package:flutter_application_illumina/screens/metodosEstudos.dart';
import 'package:flutter_application_illumina/screens/perfil/perfil.dart';
import 'package:flutter_application_illumina/screens/tarefa/tarefas.dart';
import 'package:flutter_application_illumina/screens/pomodoro/pomodoro.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const MetodosEstudos(),
    const Tarefas(),
    const Pomodoro(),
    const Agenda(),
    const Perfil(),
    const Login(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(65, 72, 83, 1),
        selectedItemColor: Color.fromRGBO(255, 234, 0, 1),
        unselectedItemColor: Color.fromRGBO(131, 135, 141, 1),
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Metodos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Tarefas',
            // Adicionando o novo ícone para Pomodoro )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: 'Login',
          )
        ],
      ),
    );
  }
}
