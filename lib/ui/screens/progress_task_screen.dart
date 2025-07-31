import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/progress_task_controller.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProgressTaskController>().getProgressTaskList();
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
                child: GetBuilder<ProgressTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ListView.builder(
                        itemCount: controller.progressTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskType: TaskType.progress,
                            taskModel: controller.progressTaskList[index],
                            onStatusUpdate: () {
                              Get.find<ProgressTaskController>()
                                  .getProgressTaskList();
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

  // Future<void> _getProgressTaskList() async {
  //   _getNewTasksListInProgress = true;
  //   if(mounted){
  //     setState(() {});
  //   }
  //
  //
  //   NetworkResponse response = await NetworkCaller.getRequest(
  //     url: Urls.getProgressTasksUrl,
  //   );
  //
  //   if (response.isSuccess) {
  //     List<TaskModel> list = [];
  //     for (Map<String, dynamic> jsonData in response.body!['data']) {
  //       list.add(TaskModel.formJson(jsonData));
  //     }
  //     _progressTaskList = list;
  //   } else {
  //     ShowSnackBarMessage(context, response.errorMessage!);
  //   }
  //
  //   _getNewTasksListInProgress = false;
  //   if(mounted){
  //     setState(() {});
  //   }
  // }
}
