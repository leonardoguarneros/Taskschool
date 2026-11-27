import 'package:flutter/material.dart';

import '../data/materias.dart';
import '../models/tarea.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/etiqueta_prioridad.dart';

class TareasScreen extends StatefulWidget {
  final String? materia;

  const TareasScreen({super.key, this.materia});

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

  void mostrar(String texto) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> cargarTareas() async {
    try {
      final lista = await ApiService.instancia.obtenerTareas();
      if (!mounted) return;
      setState(() {
        tareas = lista;
      });
    } on ApiException catch (e) {
      mostrar(e.mensaje);
    } catch (_) {
      mostrar('No se pudo conectar con el servidor');
    }
  }

  void agregarTarea() {
    String? materiaElegida = widget.materia;
    final opciones = materiasPorNivel[nivelActual.value]!
        .map((m) => m.nombre)
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialog) {
            return AlertDialog(
              title: Text('Nueva tarea'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controlador,
                      decoration: InputDecoration(
                        hintText: 'Título de la tarea',
                      ),
                    ),
                    if (widget.materia == null) ...[
                      SizedBox(height: 16),
                      Text('Materia'),
                      SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: opciones.map((o) {
                          return ChoiceChip(
                            label: Text(o),
                            selected: materiaElegida == o,
                            onSelected: (activado) {
                              setDialog(() {
                                materiaElegida = activado ? o : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
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
                      try {
                        await ApiService.instancia.insertarTarea(
                          Tarea(titulo: titulo, materia: materiaElegida),
                        );
                        await cargarTareas();
                      } catch (_) {
                        mostrar('No se pudo guardar la tarea');
                      }
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibles = widget.materia == null
        ? tareas
        : tareas.where((t) => t.materia == widget.materia).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.materia ?? 'Mis tareas')),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarTarea,
        backgroundColor: Color(0xFF2B7BE4),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: visibles.isEmpty
          ? Center(
              child: Text(
                widget.materia == null
                    ? 'Aún no tienes tareas. Toca + para agregar una.'
                    : 'No hay tareas de ${widget.materia}. Toca + para agregar una.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: visibles.length,
              itemBuilder: (context, i) {
                final tarea = visibles[i];

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
                      setState(() {
                        tarea.hecha = valor!;
                      });
                      try {
                        await ApiService.instancia.actualizarTarea(tarea);
                      } catch (_) {
                        setState(() {
                          tarea.hecha = !valor!;
                        });
                        mostrar('No se pudo actualizar la tarea');
                      }
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
                    subtitle: tarea.materia == null
                        ? null
                        : Text(tarea.materia!),
                  ),
                );
              },
            ),
    );
  }
}
