import 'package:flutter/material.dart';

class TareasScreen extends StatelessWidget {
  TareasScreen({super.key});

  final List<String> tareas = [
    'Tarea de matemáticas',
    'Tarea de historia',
    'Tarea de inglés',
    'Lectura de inglés',
    'Lectura de álgebra',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis tareas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: tareas.length,
        itemBuilder: (context, i) {
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            color: Color(0xFF2B7BE4),
            child: ListTile(
              leading: Icon(Icons.check_box_outline_blank, color: Colors.white),
              title: Text(tareas[i], style: TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
