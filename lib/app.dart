import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case SplashScreen.name:
            return MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            );
          case SingInScreen.name:
            return MaterialPageRoute(
              builder: (context) => const SingInScreen(),
            );
          case SingUpScreen.name:
            return MaterialPageRoute(
              builder: (context) => const SingUpScreen(),
            );
          case HomeScreen.name:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case EmailVerificationScreen.name:
            return MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen(),
            );
          case AddTaskScreen.name:
            return MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            );
          case UpdateProfileScreen.name:
            return MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            );

          case PinVerificationScreen.name:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PinVerificationScreen(email: args['email']),
            );

          case SetPasswordScreen.name:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) =>
                  SetPasswordScreen(email: args['email'], otp: args['otp']),
            );

          default:
            return MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            );
        }
      },
    );
  }
}
