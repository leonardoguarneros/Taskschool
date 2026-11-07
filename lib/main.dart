import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() => runApp(const TaskSchoolApp());

class TaskSchoolApp extends StatelessWidget {
  const TaskSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
