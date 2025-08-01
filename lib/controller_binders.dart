import 'package:get/get.dart';
import 'package:task_manager/ui/controller/add_task_controller.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/canceled_task_controller.dart';
import 'package:task_manager/ui/controller/complete_task_controller.dart';
import 'package:task_manager/ui/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/controller/progress_task_controller.dart';
import 'package:task_manager/ui/controller/sing_in_controller.dart';
import 'package:task_manager/ui/controller/task_status_count_controller.dart';
import 'package:task_manager/ui/controller/update_profile_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SingInController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountController());
    Get.put(ProgressTaskController());
    Get.put(CompleteTaskController());
    Get.put(CanceledTaskController());
    Get.put(UpdateProfileController());
    Get.put(AuthController());
    Get.put(AddTaskController());
  }
}
