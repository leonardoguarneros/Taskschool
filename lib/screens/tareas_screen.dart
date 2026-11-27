import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../models/tarea.dart';
import '../theme/app_theme.dart';
import '../widgets/etiqueta_prioridad.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  List<Tarea> tareas = [];

  final TextEditingController controlador = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarTareas();
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  Future<void> cargarTareas() async {
    final lista = await DbHelper.instancia.obtenerTareas();
    if (!mounted) return;
    setState(() {
      tareas = lista;
    });
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
              onPressed: () async {
                final titulo = controlador.text.trim();
                if (titulo.isNotEmpty) {
                  await DbHelper.instancia.insertarTarea(
                    Tarea(titulo: titulo, prioridad: 'Media'),
                  );
                  await cargarTareas();
                }
                controlador.clear();
                if (context.mounted) Navigator.pop(context);
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
      body: tareas.isEmpty
          ? Center(
              child: Text('Aún no tienes tareas. Toca + para agregar una.'),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: tareas.length,
              itemBuilder: (context, i) {
                final tarea = tareas[i];

                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.fondoTarjeta(context),
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
                    onChanged: (valor) async {
                      final actualizada = Tarea(
                        id: tarea.id,
                        titulo: tarea.titulo,
                        prioridad: tarea.prioridad,
                        hecha: valor!,
                      );
                      await DbHelper.instancia.actualizarTarea(actualizada);
                      await cargarTareas();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Color(0xFF2B7BE4),
                    secondary: EtiquetaPrioridad(prioridad: tarea.prioridad),
                    title: Text(
                      tarea.titulo,
                      style: TextStyle(
                        decoration: tarea.hecha
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
