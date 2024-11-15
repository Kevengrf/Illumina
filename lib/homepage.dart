import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/metodosEstudos.dart';
import 'package:flutter_application_illumina/screens/tarefa/tarefas.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const MetodosEstudos(),
    const Tarefas()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.white70,
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
            icon: Icon(Icons.person),
            label: 'Tarefas',
          ),
        ],
      ),
    );
  }
}