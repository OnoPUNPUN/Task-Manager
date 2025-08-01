import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/Forget%20Password%20Controller/email_verification_controller.dart';
import 'package:task_manager/ui/screens/Forgot%20Password%20Screens/pin_verification_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../sing_in_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String name = '/email-verification';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(42),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 170),
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A 6 digit verification pin will be sent to your email address',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String email = value ?? '';
                      if (!EmailValidator.validate(email)) {
                        return 'Enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<EmailVerificationController>(
                    builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _onTapConfirmButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Have account? ',
                        style: const TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                              color: Color(0xFF21bf73),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
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

  void _onTapSignInButton() {
    Get.offNamed(SingInScreen.name);
  }

  void _onTapConfirmButton() {
    if (_formKey.currentState!.validate()) {
      _verifyEmail();
    }
  }

  Future<void> _verifyEmail() async {
    final bool isSuccess = await _emailVerificationController.verifyEmail(
      email: _emailTEController.text.trim(),
    );

    if (isSuccess) {
      Get.offNamed(
        PinVerificationScreen.name,
        arguments: _emailTEController.text.trim(),
      );
    } else {
      if (mounted) {
        ShowSnackBarMessage(
          context,
          _emailVerificationController.errorMessage!,
        );
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
