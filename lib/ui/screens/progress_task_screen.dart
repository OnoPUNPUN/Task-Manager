import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getNewTasksListInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProgressTaskList();
    });
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
                  visible: _getNewTasksListInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemCount: _progressTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskType: TaskType.progress,
                        taskModel: _progressTaskList[index],
                        onStatusUpdate: () {
                          _getProgressTaskList();
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
    );
  }

  Future<void> _getProgressTaskList() async {
    _getNewTasksListInProgress = true;
    if(mounted){
      setState(() {});
    }


    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.formJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      ShowSnackBarMessage(context, response.errorMessage!);
    }

    _getNewTasksListInProgress = false;
    if(mounted){
      setState(() {});
    }
  }
}
