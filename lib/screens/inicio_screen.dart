import 'package:flutter/material.dart';

import '../models/clase.dart';
import '../models/tarea.dart';
import '../services/api_service.dart';
import '../widgets/etiqueta_prioridad.dart';
import '../widgets/tarjeta_azul.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  List<Tarea> tareas = [];
  List<Clase> horario = [];

  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    try {
      final listaTareas = await ApiService.instancia.obtenerTareas();
      final listaHorario = await ApiService.instancia.obtenerHorario();
      if (!mounted) return;
      setState(() {
        tareas = listaTareas;
        horario = listaHorario;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo conectar con el servidor')),
      );
    }
  }

  Widget filaClase(Clase c, bool esSiguiente) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(c.hora)),
          Expanded(
            child: Text(
              c.materia,
              style: TextStyle(
                fontWeight: esSiguiente ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (esSiguiente)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFDCE8FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Siguiente',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B2A6F),
                ),
              ),
            ),
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

    final hoy = DateTime.now();
    final clasesHoy = horario.where((c) => c.dia == hoy.weekday).toList();
    final ahora =
        '${hoy.hour.toString().padLeft(2, '0')}:${hoy.minute.toString().padLeft(2, '0')}';
    Clase? siguiente;
    for (final c in clasesHoy) {
      if (c.hora.compareTo(ahora) >= 0) {
        siguiente = c;
        break;
      }
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (clasesHoy.isEmpty)
                Text('No tienes clases registradas para hoy')
              else
                for (final c in clasesHoy) filaClase(c, c == siguiente),
              SizedBox(height: 8),
              TextButton.icon(
                icon: Icon(Icons.edit_calendar),
                label: Text('Editar horario'),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/horario');
                  cargar();
                },
              ),
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
