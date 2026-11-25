import 'package:flutter/material.dart';

class TareasScreen extends StatelessWidget {
  const TareasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis tareas')),
      body: Center(child: Text('Aquí irá la lista de tareas')),
    );
  }
}
