import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/UI/EditTask/edit_task_screen.dart';
import 'package:to_do/UI/dialogutils.dart';
import '../../Providers/tasks_provider.dart';

class TaskWidget extends StatefulWidget {
  Task? task;
  TaskWidget({super.key,this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            label: "Delete",
          ),
          SlidableAction(
            onPressed: (context) {
             Navigator.push(context,MaterialPageRoute(builder: (_)=>EditTaskScreen(task: widget.task!)));
            },
            icon: Icons.edit,
            backgroundColor: Colors.grey,
            label: "Edit",
          ),
        ],
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: 400,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 90,
                decoration: BoxDecoration(
                    color:widget.task!.isDone!? theme.colorScheme.onSecondary: theme.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task?.title ?? "",
                      style: theme.textTheme.titleLarge!.copyWith(
                         color: widget.task!.isDone!? theme.colorScheme.onSecondary: theme.primaryColor,
                      )
                    ),
                    Text(
                      widget.task?.description ?? "",
                      style: theme.textTheme.titleSmall
                    ),
                  ],
                ),
              )),
              InkWell(
                onTap: () {
                  widget.task!.isDone = !widget.task!.isDone!;
                  isDone();
                },
                child: Container(
                  width: 70,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        widget.task!.isDone! ? Colors.transparent : theme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.task!.isDone!
                      ? Text(
                          "Done!",
                          style: theme.textTheme.titleMedium
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    Dialogutils.showMessage(context, "are you sure to delete this task?",
        posActionTitle: "Yes",
        posAction: () {
          deleteTaskFromFireStore();
          Navigator.pop(context);
        },
        negActionTitle: "Cancel",
        negAction: () {
          Navigator.pop(context);
        });
  }

  deleteTaskFromFireStore() async {
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    await tasksProvider.deleteTask(widget.task!);
  }

  isDone() {
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    tasksProvider.isDoneTask(widget.task!);
  }

}
