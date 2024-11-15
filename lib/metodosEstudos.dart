import 'package:flutter/material.dart';

class MetodosEstudos extends StatelessWidget {
  const MetodosEstudos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metodos de Estudo'),
      ),
      body: const Column(
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