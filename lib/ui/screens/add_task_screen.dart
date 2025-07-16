import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAppBar(),
      body: SafeArea(
        child: ScreenBackground(
          child: Form(
            key: _globalKey,
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(hintText: 'Subject'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 10,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_globalKey.currentState!.validate()) {}
    Navigator.pop(context);
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createNewTaskUrl,
      body: requestBody,
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _descriptionTEController.clear();
      ShowSnackBarMessage(context, 'Task Added Successfully');
      setState(() {});
    } else {
      ShowSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
