import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../services/api_service.dart';
import '../widgets/tarjeta_azul.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({super.key});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  List<Tarea> pendientes = [];

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
        pendientes = lista.where((t) => !t.hecha).toList();
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo conectar con el servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
          onDateChanged: (fecha) {},
        ),
        TarjetaAzul(
          titulo: 'Pendientes',
          contenido: pendientes.isEmpty
              ? Text('Sin tareas pendientes')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: pendientes
                      .map((t) => Text('• ${t.titulo}'))
                      .toList(),
                ),
        ),
      ],
    );
  }
}
