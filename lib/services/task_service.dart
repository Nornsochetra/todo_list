import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tasks.dart';

class TaskService {
  final String BaseUrl = "https://6982b4339c3efeb892a30e71.mockapi.io/api/v1/todo";

  // get all task
  Future<List<Tasks>> fetchAllTasks() async {
    var response = await http.get(Uri.parse("$BaseUrl/getAll"));

    if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((e) => Tasks.fromJson(e)).toList();
    }else{
      throw Exception('Failed to load tasks');
    }
  }

  // create task
  Future<Tasks> createTasks(String title) async {
    var response = await http.post(
      Uri.parse("$BaseUrl/getAll"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'isDone': false
      })
    );

    if(response.statusCode == 201 || response.statusCode == 200){
      return Tasks.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to create task');
    }
  }

  // update task by id
  Future<Tasks> updateTaskById({
    required String id,
    required bool isDone
  }) async {
    var response = await http.patch(
        Uri.parse('$BaseUrl/getAll/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'isDone': isDone
        })
    );

    if(response.statusCode == 200){
      return Tasks.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to update task $id');
    }
  }

  // delete task by id
  Future<void> deleteTaskById(String id) async {
    var response = await http.delete(Uri.parse('$BaseUrl/getAll/$id'));

    if(response.statusCode == 200){
      print('Task $id delete successfully');
    }else{
      throw Exception('Failed to delete task $id!');
    }
  }

}