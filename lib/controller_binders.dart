import 'package:get/get.dart';
import 'package:task_manager/ui/controller/sing_in_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SingInController());
  }

}