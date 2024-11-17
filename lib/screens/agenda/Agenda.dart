import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => AgendaState();
}

class AgendaState extends State<Agenda> {

  DateTime today = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: content(),
    );
  }
  Widget content() {
    return Column(children: [
      Container(
        child: TableCalendar(
          locale: "pt_BR",
        focusedDay: today,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime(2030, 3, 14)),
      )
    ],
    );
  }
}
