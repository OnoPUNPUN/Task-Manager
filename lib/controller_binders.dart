import 'package:get/get.dart';
import 'package:task_manager/ui/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/controller/sing_in_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SingInController());
    Get.put(NewTaskListController());
  }

}