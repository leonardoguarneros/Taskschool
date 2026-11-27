import 'package:flutter/material.dart';
import 'inicio_screen.dart';
import 'calendario_screen.dart';
import 'materias_screen.dart';
import 'ajustes_screen.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  int indice = 0;

  final List<Widget> paginas = [
    InicioScreen(),
    CalendarioScreen(),
    MateriasScreen(),
    AjustesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: paginas[indice]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            indice = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Materias'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}