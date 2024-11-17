import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<StatefulWidget> createState() => PerfilState();
}

class PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    Intl.defaultLocale = 'pt_BR';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                child: (const Text(
                  "NeymarJr",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.person_outlined,
                    color: Colors.white,
                    size: 37,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Flex(
                 direction: Axis.vertical,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Opacity(
                       opacity: 0.5,
                       child: (Padding(
                           padding: EdgeInsets.only(left: 8.0),
                           child: (Text(
                             "E-mail",
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w100,
                               color: Colors.white,
                             ),
                           ))))),
                   Row(
                     children: [
                       Expanded(
                         child: Card(
                           child: ListTile(
                             title: Text("NeymarJR@gmail.com"),
                           ),
                         ),
                       ),
                       Icon(
                         Icons.edit_outlined,
                         color: Colors.white,
                       ),
                     ],
                   ),
                 ],
               ),
               const Flex(
                 direction: Axis.vertical,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Opacity(
                       opacity: 0.5,
                       child: (Padding(
                           padding: EdgeInsets.only(left: 8.0),
                           child: (Text(
                             "Nome de Usuário",
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w100,
                               color: Colors.white,
                             ),
                           ))))),
                   Row(
                     children: [
                       Expanded(
                         child: Card(
                           child: ListTile(
                             title: Text("NeymarJR"),
                           ),
                         ),
                       ),
                       Icon(
                         Icons.edit_outlined,
                         color: Colors.white,
                       ),
                     ],
                   ),
                 ],
               ),
               const Flex(
                 direction: Axis.vertical,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Opacity(
                       opacity: 0.5,
                       child: (Padding(
                           padding: EdgeInsets.only(left: 8.0),
                           child: (Text(
                             "Senha",
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w100,
                               color: Colors.white,
                             ),
                           ))))),
                   Row(
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
            ],
          ),
        )
      ],
    ));
  }
}
