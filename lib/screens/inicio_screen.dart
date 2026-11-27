import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/tarea.dart';
import '../widgets/etiqueta_prioridad.dart';
import '../widgets/tarjeta_azul.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  List<Tarea> tareas = [];

  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    final lista = await DbHelper.instancia.obtenerTareas();
    if (!mounted) return;
    setState(() {
      tareas = lista;
    });
  }

  Widget filaHorario(String hora, String materia) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(hora)),
          Text(materia),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendientes = tareas.where((t) => !t.hecha).toList();
    final hechas = tareas.length - pendientes.length;
    final progreso = tareas.isEmpty ? 0.0 : hechas / tareas.length;
    final proxima = pendientes.isEmpty
        ? null
        : pendientes.firstWhere(
            (t) => t.prioridad == 'Alta',
            orElse: () => pendientes.first,
          );

    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        TarjetaAzul(
          titulo: 'Próximas tareas',
          contenido: pendientes.isEmpty
              ? Text('No tienes tareas pendientes')
              : Column(
                  children: pendientes.take(3).map((t) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(child: Text(t.titulo)),
                          EtiquetaPrioridad(prioridad: t.prioridad),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
        TarjetaAzul(
          titulo: 'Horario del día',
          contenido: Column(
            children: [
              filaHorario('9:00', 'Inglés'),
              filaHorario('10:00', 'Física'),
              filaHorario('11:00', 'Matemáticas'),
              filaHorario('1:00', 'Receso'),
            ],
          ),
        ),
        TarjetaAzul(
          titulo: 'Rendimiento',
          contenido: Row(
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: progreso,
                        strokeWidth: 8,
                        backgroundColor: Color(0xFFDCE8FA),
                        color: Color(0xFF2B7BE4),
                      ),
                    ),
                    Text(
                      '${(progreso * 100).round()}%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text('$hechas de ${tareas.length} tareas completadas'),
              ),
            ],
          ),
        ),
        TarjetaAzul(
          titulo: 'Mis tareas',
          contenido: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tienes ${pendientes.length} tareas pendientes'),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B7BE4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/tareas');
                    cargar();
                  },
                  child: Text('Ver todas las tareas'),
                ),
              ),
            ],
          ),
        ),
        TarjetaAzul(
          titulo: 'Próxima entrega',
          contenido: Text(
            proxima == null
                ? 'Sin entregas pendientes'
                : '${proxima.titulo}\nPrioridad: ${proxima.prioridad}',
          ),
        ),
      ],
    );
  }
}