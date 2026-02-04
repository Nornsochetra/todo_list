import 'package:flutter/material.dart';
import '../models/tasks.dart';
import '../widget/task_items.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  List<Tasks> tasks = [];
  TextEditingController textEditingController = TextEditingController();

  void addTask(){
    if(textEditingController.text.isEmpty) return;

    setState(() {
      tasks.add(Tasks(title: textEditingController.text));
      textEditingController.clear();
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My daily tasks'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white70,
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(top: 30,bottom: 12,left: 12,right: 12),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          hintText: 'Enter Tasks',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          filled: true,
                          fillColor: Colors.white70
                      ),
                    )
                ),
                SizedBox(width: 8),
                ElevatedButton(
                    onPressed: addTask,
                    child: Text('Add Tasks')
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItems(
                    task: tasks[index],
                    onToggle: () => toggleTask(index),
                    onDelete: () => deleteTask(index),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}