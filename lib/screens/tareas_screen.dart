import 'package:flutter/material.dart';

import '../models/tarea.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  final List<Tarea> tareas = [
    Tarea(titulo: 'Tarea de matemáticas'),
    Tarea(titulo: 'Tarea de historia'),
    Tarea(titulo: 'Tarea de inglés'),
    Tarea(titulo: 'Lectura de inglés'),
    Tarea(titulo: 'Lectura de álgebra'),
  ];

  final TextEditingController controlador = TextEditingController();

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  void agregarTarea() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nueva tarea'),
          content: TextField(
            controller: controlador,
            decoration: InputDecoration(hintText: 'Título de la tarea'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controlador.clear();
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controlador.text.trim().isNotEmpty) {
                  setState(() {
                    tareas.add(Tarea(titulo: controlador.text.trim()));
                  });
                }
                controlador.clear();
                Navigator.pop(context);
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis tareas')),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarTarea,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: tareas.length,
        itemBuilder: (context, i) {
          final tarea = tareas[i];
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            color: Color(0xFF2B7BE4),
            child: CheckboxListTile(
              value: tarea.hecha,
              onChanged: (valor) {
                setState(() {
                  tarea.hecha = valor!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: Color(0xFF2B7BE4),
              activeColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
              title: Text(
                tarea.titulo,
                style: TextStyle(
                  color: Colors.white,
                  decoration: tarea.hecha ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
