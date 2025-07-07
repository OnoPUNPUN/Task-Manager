import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAppBar(),
      body: SafeArea(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Subject'
                  ),
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Description'
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: (){},
                  child: Icon(Icons.arrow_circle_right_outlined, size: 25,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
