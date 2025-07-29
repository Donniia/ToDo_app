import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/AppTheme/app_theme.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/UI/widgets/CustomFormField.dart';

import '../Home/home_screen.dart';

class EditTaskScreen extends StatefulWidget {
  Task task;

  EditTaskScreen({required this.task}) {
    titleController.text = task.title!;
    descriptionController.text = task.description!;
  }
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late DateTime newDate = widget.task.dateTime!.toDate();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TasksProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Your Task"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(45),
        padding:const EdgeInsets.all(45),
        width: 350,
        height: 650,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Text(
              "Edit Task",
              style: theme.textTheme.titleLarge,
            ),
            CustomFormField(
              hint: "title",
              controller: widget.titleController,
            ),
            CustomFormField(
              hint: "description",
              controller: widget.descriptionController,
            ),
            InkWell(
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: widget.task.dateTime!.toDate(),
                    firstDate:
                    widget.task.dateTime!.toDate().subtract(Duration(days: 30)),
                    lastDate:
                    widget.task.dateTime!.toDate().add(Duration(days: 30)));
                date == null
                    ? newDate = widget.task.dateTime!.toDate()
                    : newDate = date;
                print(newDate);
                  setState(() {

                  });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
                child: Text(
                  '${newDate.day} /${newDate.month} / ${newDate.year} ',
                  style: TextStyle(color: Color(0xff383838)),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(onPressed: (){
              widget.task.title = widget.titleController.text;
              widget.task.description = widget.descriptionController.text;
              widget.task.dateTime = Timestamp.fromMillisecondsSinceEpoch(newDate.millisecondsSinceEpoch);
              taskProvider.editTask(widget.task);
              Navigator.pop(context);
            }, child: Text("Save Changes"))
          ],
        ),
      ),
    );
  }
}
