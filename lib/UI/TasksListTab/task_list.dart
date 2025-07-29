import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/Auth_Provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/UI/TasksListTab/task_widget.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  DateTime _selectedDate = DateTime.now();

  @override
  @override
  Widget build(BuildContext context) {
   var theme = Theme.of(context);
    var tasksProvider = Provider.of<TasksProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (
            date
          ) {
            setState(() {
              _selectedDate = date;
            });
          },
          monthColor: theme.colorScheme.background,
          dayColor: theme.colorScheme.background,
          activeBackgroundDayColor: theme.colorScheme.secondaryContainer,
          activeDayColor: theme.primaryColor,
        ),
        Expanded(
            child: FutureBuilder(
          future: tasksProvider.getAllTask(_selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text("Something Went Wrong. please try gain"),
                  ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                ],
              );
            }

            var tasksList = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskWidget(
                  task: tasksList![index],
                );
              },
              itemCount: tasksList?.length ?? 0,
            );
          },
        ))
      ],
    );
  }
}
