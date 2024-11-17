import 'package:flutter/material.dart';

class MetodosEstudos extends StatelessWidget {
  const MetodosEstudos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
            'Tela de Metodos de Estudos',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red),
          ),
          )
        ],
      ),
    );
  }
}