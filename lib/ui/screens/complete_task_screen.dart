import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/complete_task_controller.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CompleteTaskController>().getCompletedTaskList();
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
                child: GetBuilder<CompleteTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ListView.builder(
                        itemCount: controller.completedTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskType: TaskType.completed,
                            taskModel: controller.completedTaskList[index],
                            onStatusUpdate: () {
                              Get.find<CompleteTaskController>()
                                  .getCompletedTaskList();
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _getCompletedTaskList() async {
  //   _getCompletedTaskInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //
  //   NetworkResponse response = await NetworkCaller.getRequest(
  //     url: Urls.getCompleteTasksUrl,
  //   );
  //
  //   if (response.isSuccess) {
  //     List<TaskModel> list = [];
  //     for (Map<String, dynamic> item in response.body!['data']) {
  //       list.add(TaskModel.formJson(item));
  //     }
  //     _completedTaskList = list;
  //   } else {
  //     ShowSnackBarMessage(context, response.errorMessage!);
  //   }
  //   _getCompletedTaskInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }
}
