import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';

import '../widgets/task_card.dart';

class CanceledTaskList extends StatefulWidget {
  const CanceledTaskList({super.key});

  @override
  State<CanceledTaskList> createState() => _CanceledTaskListState();
}

class _CanceledTaskListState extends State<CanceledTaskList> {
  bool _getCancelledTasksListInProgress = false;
  List<TaskModel> _canceledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCanceledTaskList();
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
                  visible: _getCancelledTasksListInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemCount: _canceledTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskType: TaskType.cancelled,
                        taskModel: _canceledTaskList[index],
                        onStatusUpdate: () {
                          _getCanceledTaskList();
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

  Future<void> _getCanceledTaskList() async {
    _getCancelledTasksListInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCancelledTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> item in response.body!['data']) {
        list.add(TaskModel.formJson(item));
      }
      _canceledTaskList = list;
    }
    _getCancelledTasksListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
