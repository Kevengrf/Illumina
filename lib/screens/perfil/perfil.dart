import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/data/PerfilData.dart';
import 'package:flutter_application_illumina/models/Usuario.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<StatefulWidget> createState() => PerfilState();
}
class PerfilState extends State<Perfil> {
  Usuario? usuario;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    Intl.defaultLocale = 'pt_BR';
    _loadUsuario();
  }

  Future<void> _loadUsuario() async {
    final usuarioData = UsuarioData();
    final fetchedUsuario = await usuarioData.getLastUsuario();
    setState(() {
      usuario = fetchedUsuario;
    });
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
          'Perfil',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: usuario == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        usuario!.nome ?? "Nome não disponível",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.person_outlined,
                          color: Colors.white,
                          size: 37,
                        ),
                      ),
                      const SizedBox(height: 50),
                      
                      const Opacity(
                        opacity: 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "E-mail",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: ListTile(
                                title: Text(usuario!.email ?? "Email não disponível"), 
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    
                      const Opacity(
                        opacity: 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Nome de Usuário",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: ListTile(
                                title: Text(usuario!.nome ?? "Nome não disponível"), 
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                   
                      const Opacity(
                        opacity: 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Senha",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: ListTile(
                                title: Text("***************"),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
