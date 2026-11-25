import 'package:flutter/material.dart';

import '../widgets/tarjeta_azul.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  Widget filaHorario(String hora, String materia) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(hora, style: TextStyle(color: Colors.white)),
          ),
          Text(materia, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: [
        TarjetaAzul(
          titulo: 'Próximas tareas (Hoy)',
          contenido: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ejercicios Matemáticas   Hoy 16:00',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Leer cap.7 Álgebra II   Hoy 16:30',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Leer cap.3 Historia   Hoy 18:00',
                style: TextStyle(color: Colors.white),
              ),
            ],
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
          contenido: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: 0.6,
                strokeWidth: 12,
                backgroundColor: Colors.white,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        TarjetaAzul(
          titulo: 'Mis tareas',
          contenido: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consultar todas tus tareas',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tareas');
                },
                child: Text('Ver todas las tareas'),
              ),
            ],
          ),
        ),
        TarjetaAzul(
          titulo: 'Próxima entrega',
          contenido: Text(
            'Matemáticas: Resolver ejercicios de álgebra\nEntrega: Mañana',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
