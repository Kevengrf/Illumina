import 'package:flutter/material.dart';
import 'package:flutter_application_illumina/screens/agenda/Evento.dart';
import 'package:table_calendar/table_calendar.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => AgendaState();
}
class AgendaState extends State<Agenda> {

  DateTime today = DateTime.now();
  //DateTime selectedDay = DateTime.now();
  late final ValueNotifier<List<Evento>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<Evento>> events = {};
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)
    
    );
    loadPreviousEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

    List<Evento> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  List<Evento> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final day in days) ..._getEventsForDay(day),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }
  daysInRange(DateTime start, DateTime end) {}

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        TableCalendar(
        locale: "pt_BR",
        rowHeight: 43,
        availableGestures: AvailableGestures.all,
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime(2030, 3, 14),
        weekendDays: const [DateTime.saturday, DateTime.sunday],
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: _onDaySelected,
        onRangeSelected: _onRangeSelected,
        onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },

        headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(color: Colors.white),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),
          calendarStyle: const CalendarStyle(
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
          daysOfWeekStyle: const DaysOfWeekStyle(weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Color.fromRGBO(255, 234, 0, 1),)
            ),
          ),
        Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.onInverseSurface),
child: ValueListenableBuilder(
  valueListenable: _selectedEvents,
  builder: (context, value, _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: value.map<Widget>((e) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(e.title),
            subtitle: Text(e.description),
          ),
        );
      }).toList(),
    );
  },
)

        )
          ],
        ),
        ),
        
              floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // todo: Show dialog to user to input event
            showDialog(
                context: context, builder: (_) => _dialogWidget(context));
          },
          label: const Text(
            'Add Eventos',
            style: TextStyle(
              color: Colors.black,
              ),
            ),
          icon: const Icon(
            Icons.add,
            color: Colors.black,
            ),
          backgroundColor: const Color.fromRGBO(255, 234, 0, 1),
        ),
      ),
    );
  }

  Widget textBtn(BuildContext context, String text, VoidCallback voidCallback) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          voidCallback();
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  AlertDialog _dialogWidget(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: true,
      title: const Text('Nome do evento'),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(helperText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(helperText: 'Descrição'),
            ),
          ],
        ),
      ),
      actions: [
  ElevatedButton(
    onPressed: () {
      events.addAll({
        _selectedDay!: [
          ..._selectedEvents.value,
          Evento(
            title: _titleController.text,
            description: _descriptionController.text
          )
        ]
      });
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
      clearController();
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(255, 234, 0, 1),
    ),
    child: const Text('Enviar')
  )
]

    );
  }

  void loadPreviousEvents() {
    events = {
      _selectedDay!: [Evento(title: '', description: '')],
      _selectedDay!: [Evento(title: '', description: '')]
    };
  }
}
  
