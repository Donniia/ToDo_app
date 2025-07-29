import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Database/tasks_dao.dart';
import 'package:to_do/Providers/Auth_Provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/UI/dialogutils.dart';
import 'package:to_do/UI/widgets/CustomFormField.dart';

import '../../Database/Model/Task.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add new task",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff383838)),
            ),
            CustomFormField(
              hint: 'Title',
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "please enter task title";
                }
              },
              controller: titleController,
            ),
            CustomFormField(
              hint: 'Description',
              lines: 4,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "please enter task description";
                }
              },
              controller: descriptionController,
            ),
            InkWell(
              onTap: () {
                showTaskDatePiker();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
                child: Text(
                  selectedDate == null
                      ? "Select Date"
                      : "${selectedDate?.day} / ${selectedDate?.month} / ${selectedDate?.year}",
                  style: TextStyle(color: Color(0xff383838)),
                ),
              ),
            ),
            Visibility(
              visible: showDateError,
              child: Text(
                "Please select task date",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  bool showDateError = false;
  bool isValidForm() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (selectedDate == null) {
      setState(() {
        showDateError = true;
      });
      isValid = false;
    }
    return isValid;
  }

  void addTask() async {
    if (!isValidForm()) return;

    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: Timestamp.fromMillisecondsSinceEpoch(
            selectedDate!.millisecondsSinceEpoch));
    Dialogutils.showMessage(context, "Creating task....");
    await tasksProvider.addTask(task);
    Dialogutils.HideDialog(context);
    Dialogutils.showMessage(context, "Task Created Successfullly",
        isCanceled: false, posActionTitle: 'ok', posAction: () {
      Navigator.pop(context);
    });
  }

  DateTime? selectedDate;
  void showTaskDatePiker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    setState(() {
      selectedDate = date;
      if (selectedDate != null) {
        showDateError = false;
      }
    });
  }
}
