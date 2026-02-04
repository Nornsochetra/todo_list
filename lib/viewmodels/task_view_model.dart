import 'package:flutter/material.dart';
import 'package:todo_list_app/services/task_service.dart';
import '../models/tasks.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskService service = TaskService();

  List<Tasks> tasks = [];
  bool isLoading = false;
  String? error;

  // get all task
  Future<void> getAllTasks() async {
    isLoading = true;
    notifyListeners();

    try{
      tasks = await service.fetchAllTasks();
      error = null;
    }catch(e){
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // create tasks
  Future<void> addTask(String title) async {
    if(title.trim().isEmpty) return;

    try{
      var newTask = await service.createTasks(title);
      tasks.add(newTask);
      notifyListeners();
    }catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // update tasks by id
  Future<void> changeTaskById(String id) async {
    final index = tasks.indexWhere((t) => t.id == id);
    if(index == -1) return;

    final oldValue = tasks[index].isDone;
    tasks[index].isDone = !oldValue;
    notifyListeners(); // ui update instantly

    try{
      await service.updateTaskById(id: id, isDone: tasks[index].isDone);
    }catch (e){
      tasks[index].isDone = oldValue;
      error = e.toString();
      notifyListeners();
    }
  }

  // delete tasks by id
  Future<void> removeTaskById(String id) async {
    final index = tasks.indexWhere((t) => t.id == id);
    if(index == -1) return;

    final removedTask = tasks[index];
    tasks.removeAt(index);
    notifyListeners();

    try{
      await service.deleteTaskById(id);
    }catch (e){
      // rollback if api fails
      tasks.insert(index, removedTask);
      error = e.toString();
      notifyListeners();
    }
  }

  //
  // void toggleTask(int index) {
  //   _task[index].isDone = !_task[index].isDone;
  //   notifyListeners();
  // }
  //
}