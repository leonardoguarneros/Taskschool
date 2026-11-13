import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/principal_screen.dart';

void main() => runApp(const TaskSchoolApp());

class TaskSchoolApp extends StatelessWidget {
  const TaskSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/principal': (context) => const PrincipalScreen(),
      },
    );
  }
}
