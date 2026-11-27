import 'package:flutter/material.dart';

import '../data/materias.dart';
import '../models/clase.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';

class HorarioScreen extends StatefulWidget {
  const HorarioScreen({super.key});

  @override
  State<HorarioScreen> createState() => _HorarioScreenState();
}

class _HorarioScreenState extends State<HorarioScreen> {
  final List<String> dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
  List<Clase> clases = [];
  int dia = DateTime.now().weekday;

  @override
  void initState() {
    super.initState();
    cargar();
  }

  void mostrar(String texto) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  String formatear(TimeOfDay h) {
    final hh = h.hour.toString().padLeft(2, '0');
    final mm = h.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  Future<void> cargar() async {
    try {
      final lista = await ApiService.instancia.obtenerHorario();
      if (!mounted) return;
      setState(() {
        clases = lista;
      });
    } catch (_) {
      mostrar('No se pudo cargar el horario');
    }
  }

  Future<void> eliminar(Clase c) async {
    try {
      await ApiService.instancia.eliminarClase(c.id!);
      await cargar();
    } catch (_) {
      mostrar('No se pudo eliminar la clase');
    }
  }

  void agregarClase() {
    String? materiaElegida;
    String? horaElegida;
    final opciones = [
      ...materiasPorNivel[nivelActual.value]!.map((m) => m.nombre),
      'Receso',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialog) {
            return AlertDialog(
              title: Text('Nueva clase (${dias[dia - 1]})'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(Icons.access_time),
                      label: Text(horaElegida ?? 'Elegir hora'),
                      onPressed: () async {
                        final h = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 8, minute: 0),
                        );
                        if (h == null || !context.mounted) return;
                        setDialog(() {
                          horaElegida = formatear(h);
                        });
                      },
                    ),
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
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: (horaElegida == null || materiaElegida == null)
                      ? null
                      : () async {
                          try {
                            await ApiService.instancia.insertarClase(
                              Clase(
                                dia: dia,
                                hora: horaElegida!,
                                materia: materiaElegida!,
                              ),
                            );
                            await cargar();
                          } catch (_) {
                            mostrar('No se pudo guardar la clase');
                          }
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
    final visibles = clases.where((c) => c.dia == dia).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Mi horario')),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarClase,
        backgroundColor: Color(0xFF2B7BE4),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Wrap(
              spacing: 6,
              children: [
                for (int i = 0; i < dias.length; i++)
                  ChoiceChip(
                    label: Text(dias[i]),
                    selected: dia == i + 1,
                    onSelected: (_) {
                      setState(() {
                        dia = i + 1;
                      });
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: visibles.isEmpty
                ? Center(
                    child: Text(
                      'Sin clases este día. Toca + para agregar una.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    itemCount: visibles.length,
                    itemBuilder: (context, i) {
                      final c = visibles[i];
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
                        child: ListTile(
                          leading: Text(
                            c.hora,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          title: Text(c.materia),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () => eliminar(c),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
