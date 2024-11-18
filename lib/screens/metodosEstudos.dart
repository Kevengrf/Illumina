import 'package:flutter/material.dart';

class MetodosEstudos extends StatelessWidget {
  const MetodosEstudos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/pomodoro');
              },
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pomodoro",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.access_time,
                    size: 48,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
