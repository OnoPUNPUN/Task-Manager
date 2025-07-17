import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';

import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: _getCompletedTaskInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemCount: _completedTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskType: TaskType.completed,
                        taskModel: _completedTaskList[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    _getCompletedTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCompleteTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> item in response.body!['data']) {
        list.add(TaskModel.formJson(item));
        _completedTaskList = list;
      }
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }
}
