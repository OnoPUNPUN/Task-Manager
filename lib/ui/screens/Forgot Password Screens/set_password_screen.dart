import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/sing_in_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const SetPasswordScreen({super.key, required this.email, required this.otp});

  static const String name = '/set-password';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool _setPasswordInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(42),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 170),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Minimum length password 6 characters with letter and number combination',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    controller: _passwordTEController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Re-enter the password';
                      }
                      if (value != _passwordTEController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_setPasswordInProgress,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _onTapConfirmButton,
                      child: const Text('Confirm'),
                    ),
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
    Navigator.pushReplacementNamed(context, SingInScreen.name);
  }

  void _onTapConfirmButton() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    _setPasswordInProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      'email': widget.email,
      'OTP': widget.otp,
      'password': _passwordTEController.text.trim(),
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.recoverResetPasswordUrl,
      body: requestBody,
    );

    _setPasswordInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      ShowSnackBarMessage(
        context,
        'Password reset successful. Please sign in.',
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        SingInScreen.name,
        (route) => false,
      );
    } else {
      ShowSnackBarMessage(
        context,
        response.errorMessage ?? 'Password reset failed',
      );
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
