import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/data/doto.dart';
import 'package:to_do_app/data/firestore_utils.dart';
import 'package:to_do_app/ui/home/todo_widget.dart';

class TodoListTab extends StatefulWidget {
  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar(
              selectedDayPredicate: (day) {
                return isSameDay(day, selectedDay);
              },
              onDaySelected: (sDay, fDay) {
                setState(() {
                  selectedDay = sDay;
                  focusedDay = fDay; // update `_focusedDay` here as well
                });
              },
              calendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                selectedTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                selectedDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                todayTextStyle: TextStyle(
                  color: Colors.white,
                ),
                todayDecoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)),
                defaultDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                defaultTextStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                weekdayStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              weekendDays: [],
              focusedDay: focusedDay,
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365))),
          Expanded(
            child: StreamBuilder<QuerySnapshot<ToDo>>(
                stream: getToDOcollectionReference()
                    // .where('dateTime',isEqualTo: selectedDay.millisecondsSinceEpoch)
                    .snapshots(),
                builder: (BuildContext buildContext,
                    AsyncSnapshot<QuerySnapshot<ToDo>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<ToDo> items =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();
                  return ListView.builder(
                    itemBuilder: (buildContext, index) {
                      return TodoWidget(items[index]);
                    },
                    itemCount: items.length,
                  );
                }),
          )
        ],
      ),
    );
  }
}
