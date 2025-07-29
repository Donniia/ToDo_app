import 'package:flutter/material.dart';
import 'package:to_do/Database/Model/Task.dart';
import '../Database/tasks_dao.dart';

class TasksProvider extends ChangeNotifier{
  List<Task> tasks = [];
  String? uid;

  Future<void> addTask(Task task) async{
    await TasksDao.createTask(task, uid!);
    notifyListeners();
    return;
  }

  Future<void> deleteTask(Task task) async{
    await TasksDao.removeTask(task.id!, uid!);
    notifyListeners();
    return;
  }

  Future<List<Task>> getAllTask(DateTime selectedDate){
    return TasksDao.getAllTask(uid!,selectedDate);
  }

  Future<void> editTask( Task task) async{
    await TasksDao.editTask(task, uid!);
    notifyListeners();
  }

  Future<void> isDoneTask(Task task) async{
    await TasksDao.isDoneTask(task, uid!);
    notifyListeners();
  }
}