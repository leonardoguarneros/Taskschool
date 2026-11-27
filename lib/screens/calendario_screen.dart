import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/tarea.dart';
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
    final lista = await DbHelper.instancia.obtenerTareas();
    if (!mounted) return;
    setState(() {
      pendientes = lista.where((t) => !t.hecha).toList();
    });
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
                  children:
                      pendientes.map((t) => Text('• ${t.titulo}')).toList(),
                ),
        ),
      ],
    );
  }
}