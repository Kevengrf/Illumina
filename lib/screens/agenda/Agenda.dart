import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => AgendaState();
}

class AgendaState extends State<Agenda> {

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day,DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }


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
          rowHeight: 43,
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
        focusedDay: today,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime(2030, 3, 14),
        onDaySelected: _onDaySelected,
        headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(color: Colors.white),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(color: Colors.white),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(color: Color.fromRGBO(255, 234, 0, 1),),
            defaultTextStyle: TextStyle(color: Colors.white),
            outsideTextStyle: TextStyle(color: Colors.grey),
            markersMaxCount: 1,
            markerDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Color.fromRGBO(255, 234, 0, 1),)),
        ),
      ),
    ]);
  }
}
