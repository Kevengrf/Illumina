import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

Widget CarrosselDatas(DateTime selectedDate, Function(DateTime) onDateChange) {
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 10),
    child: DatePicker(
      DateTime.now(),
      height: 100,
      width: 70,
      initialSelectedDate: selectedDate,
      selectionColor: const Color.fromRGBO(145, 156, 174, 1),
      selectedTextColor: Colors.white,
      onDateChange: onDateChange,
      monthTextStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      dateTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      dayTextStyle: const TextStyle(fontSize: 0),
      locale: 'pt',
    ),
  );
}
