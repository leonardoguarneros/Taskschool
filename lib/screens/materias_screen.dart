import 'package:flutter/material.dart';

import '../data/materias.dart';
import '../models/tarea.dart';
import '../services/api_service.dart';
import 'tareas_screen.dart';

class MateriasScreen extends StatefulWidget {
  const MateriasScreen({super.key});

  @override
  State<MateriasScreen> createState() => _MateriasScreenState();
}

class _MateriasScreenState extends State<MateriasScreen> {
  List<Tarea> tareas = [];

  final List<Color> colores = [
    Color(0xFFDCE8FA),
    Color(0xFFFADCE8),
    Color(0xFFFAE8DC),
    Color(0xFFDCFAE8),
  ];

  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    try {
      final lista = await ApiService.instancia.obtenerTareas();
      if (!mounted) return;
      setState(() {
        tareas = lista;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudieron cargar las tareas')),
      );
    }
  }

  List<Tarea> deMateria(String nombre) {
    return tareas.where((t) => t.materia == nombre).toList();
  }

  Widget tarjetaMateria(Materia materia, int i) {
    final lista = deMateria(materia.nombre);
    final hechas = lista.where((t) => t.hecha).length;
    final pendientes = lista.length - hechas;
    final progreso = lista.isEmpty ? 0.0 : hechas / lista.length;
    const navy = Color(0xFF0B2A6F);

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TareasScreen(materia: materia.nombre),
          ),
        );
        cargar();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colores[i % colores.length],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(materia.icono, size: 28, color: navy),
                  SizedBox(height: 6),
                  Text(
                    materia.nombre,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: navy,
                    ),
                  ),
                  SizedBox(height: 8),
                  if (lista.isEmpty)
                    Text(
                      'Sin tareas',
                      style: TextStyle(fontSize: 11, color: navy),
                    )
                  else ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progreso,
                        minHeight: 6,
                        backgroundColor: Colors.white,
                        color: Color(0xFF2B7BE4),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$hechas/${lista.length}',
                      style: TextStyle(fontSize: 11, color: navy),
                    ),
                  ],
                ],
              ),
            ),
            if (pendientes > 0)
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(0xFFC62828),
                  child: Text(
                    '$pendientes',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nivel = nivelActual.value;
    final materias = materiasPorNivel[nivel]!;

    int totalTareas = 0;
    int totalHechas = 0;
    final pendientesPorMateria = <String, int>{};

    for (final m in materias) {
      final lista = deMateria(m.nombre);
      final hechas = lista.where((t) => t.hecha).length;
      totalTareas += lista.length;
      totalHechas += hechas;
      if (lista.length - hechas > 0) {
        pendientesPorMateria[m.nombre] = lista.length - hechas;
      }
    }

    final progreso = totalTareas == 0 ? 0.0 : totalHechas / totalTareas;
    final masPendientes = pendientesPorMateria.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maximo = masPendientes.isEmpty ? 1 : masPendientes.first.value;

    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        Text(
          'Materias',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: materiasPorNivel.keys.map((n) {
            return ChoiceChip(
              label: Text(n),
              selected: n == nivel,
              onSelected: (_) {
                setState(() {
                  nivelActual.value = n;
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 12),
        Text('Toca una materia para ver y agregar sus tareas'),
        SizedBox(height: 12),
        GridView.extent(
          maxCrossAxisExtent: 130,
          childAspectRatio: 0.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0; i < materias.length; i++)
              tarjetaMateria(materias[i], i),
          ],
        ),
        SizedBox(height: 24),
        Text(
          'Resumen de $nivel',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progreso),
                duration: Duration(milliseconds: 500),
                builder: (context, valor, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: valor,
                          strokeWidth: 8,
                          backgroundColor: Color(0xFFDCE8FA),
                          color: Color(0xFF2B7BE4),
                        ),
                      ),
                      Text(
                        '${(progreso * 100).round()}%',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                '$totalHechas de $totalTareas tareas completadas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Lo que más tienes pendiente',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        if (masPendientes.isEmpty)
          Text('No tienes tareas pendientes en este nivel')
        else
          for (final e in masPendientes.take(3))
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(e.key), Text('${e.value} pendientes')],
                  ),
                  SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: e.value / maximo,
                      minHeight: 8,
                      backgroundColor: Color(0xFFDCE8FA),
                      color: Color(0xFFC62828),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
