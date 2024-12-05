import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/screens/agenda/Agenda.dart';
import 'package:flutter_application_illumina/screens/login/Login.dart';
import 'package:flutter_application_illumina/screens/metodosDeEstudos/metodosEstudos.dart';
import 'package:flutter_application_illumina/screens/perfil/perfil.dart';
import 'package:flutter_application_illumina/screens/tarefa/tarefas.dart';
import 'package:flutter_application_illumina/data/UsuarioData.dart';
import 'package:flutter_application_illumina/models/Usuario.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  int currentIndex = 0;
  final screens = [
    const MetodosEstudos(),
    const Tarefas(),
    const Agenda(),
  ];
  Usuario? lastUsuario;

  @override
  void initState() {
    super.initState();
    _loadLastUsuarioData();
  }

  Future<void> _loadLastUsuarioData() async {
    Usuario? usuario = await UsuarioData().getLastUsuario();
    setState(() {
      lastUsuario = usuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 234, 0, 1)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer( 
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            lastUsuario == null
                ? const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 207, 155, 0),
                    ),
                    accountEmail: Text("Carregando..."),
                    accountName: Text("Carregando..."),
                    currentAccountPicture: CircleAvatar(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 207, 155, 0),
                    ),
                    accountEmail: Text(lastUsuario!.email ?? 'Sem email'),
                    accountName: Text(lastUsuario!.nome ?? 'Sem nome'),
                    currentAccountPicture: CircleAvatar(
                      child: Text(lastUsuario!.nome?.substring(0, 1) ?? 'U'),
                    ),
                  ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Perfil()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () async {
                await UsuarioData().logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(65, 72, 83, 1),
        selectedItemColor: const Color.fromRGBO(255, 234, 0, 1),
        unselectedItemColor: const Color.fromRGBO(131, 135, 141, 1),
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
            icon: Icon(Icons.checklist),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
        ],
      ),
    );
  }
}
