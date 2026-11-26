import 'package:flutter/material.dart';

import '../widgets/tarjeta_azul.dart';

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

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
          titulo: 'Hoy',
          contenido: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ejercicios Matemáticas   Hoy 16:00'),
              Text('Leer cap.7 Álgebra II   Hoy 16:30'),
              Text('Leer cap.3 Historia   Hoy 18:00'),
            ],
          ),
        ),
      ],
    );
  }
}
