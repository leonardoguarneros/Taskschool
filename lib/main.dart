import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/principal_screen.dart';
import 'screens/tareas_screen.dart';

void main() => runApp(const TaskSchoolApp());

class TaskSchoolApp extends StatelessWidget {
  const TaskSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/principal': (context) => const PrincipalScreen(),
        '/tareas': (context) => const TareasScreen(),
      },
    );
  }
}
