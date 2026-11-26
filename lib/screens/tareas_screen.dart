import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../widgets/etiqueta_prioridad.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  final List<Tarea> tareas = [
    Tarea(titulo: 'Leer cap.3 Historia', prioridad: 'Alta'),
    Tarea(titulo: 'Ejercicios Matemáticas', prioridad: 'Media'),
    Tarea(titulo: 'Tarea de inglés', prioridad: 'Media'),
    Tarea(titulo: 'Lectura de álgebra', prioridad: 'Alta'),
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
        backgroundColor: Color(0xFF2B7BE4),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: tareas.length,
        itemBuilder: (context, i) {
          final tarea = tareas[i];
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: CheckboxListTile(
              value: tarea.hecha,
              onChanged: (valor) {
                setState(() {
                  tarea.hecha = valor!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color(0xFF2B7BE4),
              secondary: EtiquetaPrioridad(prioridad: tarea.prioridad),
              title: Text(
                tarea.titulo,
                style: TextStyle(
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
