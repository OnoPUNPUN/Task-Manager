import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import 'add_task_screen.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTasksListInProgress = false;
  bool _getTasksStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNewTaskList();
      _getNTaskStatusCountList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: Visibility(
                  visible: _getTasksStatusCountInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _taskStatusCountList.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => TaskSummaryCard(
                      count: _taskStatusCountList[i].count,
                      title: _taskStatusCountList[i].id,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: _getNewTasksListInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskType: TaskType.tNew,
                        taskModel: _newTaskList[index],
                        onStatusUpdate: () {
                          _getNewTaskList();
                          _getNTaskStatusCountList();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _getNewTasksListInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getNewTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> item in response.body!['data']) {
        list.add(TaskModel.formJson(item));
        _newTaskList = list;
      }
    } else {
      if (mounted) {
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getNewTasksListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getNTaskStatusCountList() async {
    _getTasksStatusCountInProgress = true;
      setState(() {});


    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getTasksStatusCountUrl,
    );

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> item in response.body!['data']) {
        list.add(TaskStatusCountModel.fromJson(item));
      }
      _taskStatusCountList = list;
    } else {
      if (mounted) {
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getTasksStatusCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, AddTaskScreen.name);
  }
}
