import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:task_manager/controller_binders.dart';
import 'package:task_manager/ui/screens/add_task_screen.dart';
import 'package:task_manager/ui/screens/Forgot%20Password%20Screens/email_verification_screen.dart';
import 'package:task_manager/ui/screens/Forgot%20Password%20Screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/Forgot%20Password%20Screens/set_password_screen.dart';
import 'package:task_manager/ui/screens/home_screen.dart';
import 'package:task_manager/ui/screens/sing_in_screen.dart';
import 'package:task_manager/ui/screens/sing_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TaskMangerApp extends StatelessWidget {
  const TaskMangerApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator,
      // Retain the navigator key if needed
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Color(0xFF21bf73),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: SplashScreen.name,
      getPages: [
        GetPage(name: SplashScreen.name, page: () => const SplashScreen()),
        GetPage(name: SingInScreen.name, page: () => const SingInScreen()),
        GetPage(name: SingUpScreen.name, page: () => const SingUpScreen()),
        GetPage(name: HomeScreen.name, page: () => const HomeScreen()),
        GetPage(
          name: EmailVerificationScreen.name,
          page: () => const EmailVerificationScreen(),
        ),
        GetPage(name: AddTaskScreen.name, page: () => const AddTaskScreen()),
        GetPage(
          name: UpdateProfileScreen.name,
          page: () => const UpdateProfileScreen(),
        ),
        GetPage(
          name: PinVerificationScreen.name,
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;
            return PinVerificationScreen(email: args?['email'] ?? '');
          },
        ),
        GetPage(
          name: SetPasswordScreen.name,
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;
            return SetPasswordScreen(
              email: args?['email'] ?? '',
              otp: args?['otp'] ?? '',
            );
          },
        ),
      ],
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const SplashScreen(),
      ),
      initialBinding: ControllerBinders(),
    );
  }
}
