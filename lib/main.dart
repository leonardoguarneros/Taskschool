import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/principal_screen.dart';
import 'screens/tareas_screen.dart';
import 'screens/horario_screen.dart';

void main() => runApp(const TaskSchoolApp());

class TaskSchoolApp extends StatelessWidget {
  const TaskSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: modoTema,
      builder: (context, modo, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.tema,
          darkTheme: AppTheme.oscuro,
          themeMode: modo,
          builder: (context, child) {
            return ColoredBox(
              color: AppTheme.esOscuro(context)
                  ? Color(0xFF0A1120)
                  : Color(0xFFE9EEF7),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 480),
                  child: child,
                ),
              ),
            );
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/registro': (context) => const RegistroScreen(),
            '/principal': (context) => const PrincipalScreen(),
            '/tareas': (context) => const TareasScreen(),
            '/horario': (context) => const HorarioScreen(),
          },
        );
      },
    );
  }
}
