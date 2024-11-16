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
                    Padding(padding: new EdgeInsets.all(16), child: Column(
                        
                        children: [
                            SizedBox(height: 50),
                            Container(
                                child: (Text("NeymarJr", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),)),
                            ),
                            SizedBox(height: 20,),
                            Container(
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.person_outlined, color: Colors.white, size: 30,),
                                ),
                            )
                        ],
                    ),)

                ],
      )
    );
  }
}
