import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/viewmodels/task_view_model.dart';
import '../widget/task_items.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Flutter version of `.task {} in swiftUI`
    Future.microtask((){
      context.read<TaskViewModel>().getAllTasks();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskViewModel>();

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
                      controller: controller,
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
                    onPressed: () async {
                      await vm.addTask(controller.text);
                      controller.clear();
                    },
                    child: Text('Add Tasks')
                )
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (vm.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (vm.error != null) {
                  return Center(
                    child: Text(vm.error!),
                  );
                }

                if (vm.tasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks yet'),
                  );
                }

                return ListView.builder(
                  itemCount: vm.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItems(
                      task: vm.tasks[index],
                      onDelete: () => vm.removeTaskById(vm.tasks[index].id),
                      onToggle: () => vm.changeTaskById(vm.tasks[index].id),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}