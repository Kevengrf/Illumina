import 'package:flutter/material.dart';

class MetodosEstudos extends StatefulWidget {
  const MetodosEstudos({super.key});

  @override
  _MetodosEstudosState createState() => _MetodosEstudosState();
}

class _MetodosEstudosState extends State<MetodosEstudos> {
  int _selectedIndex = 0;

  void onPomodoroPressed() {}

  void onMapaMentalPressed() {
    print("Mapa Mental selecionado!");
  }

  void onResumoPressed() {
    print("Resumo em andamento!");
  }

  void onFlashcardsPressed() {
    print("Flashcards abertos!");
  }

  void onFichamentoPressed() {
    print("Fichamento em progresso!");
  }

  void onLeituraPressed() {
    print("Leitura ativa!");
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildButton(
                    title: 'Pomodoro',
                    icon: Icons.access_time,
                    iconColor: Colors.yellow,
                    onPressed: () {
                      Navigator.pushNamed(context, '/pomodoro');
                    },
                    isEnabled: true,
                  ),
                  _buildButton(
                    title: 'Mapa Mental',
                    icon: Icons.psychology,
                    iconColor: Colors.blue,
                    onPressed: null,
                    isEnabled: false,
                  ),
                  _buildButton(
                    title: 'Resumo',
                    icon: Icons.description,
                    iconColor: Colors.orange,
                    onPressed: null,
                    isEnabled: false,
                  ),
                  _buildButton(
                    title: 'Flashcards',
                    icon: Icons.note_alt,
                    iconColor: Colors.purple,
                    onPressed: null,
                    isEnabled: false,
                  ),
                  _buildButton(
                    title: 'Fichamento',
                    icon: Icons.library_books,
                    iconColor: Colors.green,
                    onPressed: null,
                    isEnabled: false,
                  ),
                  _buildButton(
                    title: 'Leitura',
                    icon: Icons.menu_book,
                    iconColor: Colors.red,
                    onPressed: null,
                    isEnabled: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback? onPressed,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF383D4F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isEnabled ? iconColor : Colors.grey,
                size: 36,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isEnabled ? Colors.white : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
