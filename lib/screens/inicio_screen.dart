import 'package:flutter/material.dart';

import '../widgets/tarjeta_azul.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

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
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        TarjetaAzul(
          titulo: 'Próximas tareas (Hoy)',
          contenido: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ejercicios Matemáticas   Hoy 16:00'),
              Text('Leer cap.7 Álgebra II   Hoy 16:30'),
              Text('Leer cap.3 Historia   Hoy 18:00'),
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
                backgroundColor: Color(0xFFDCE8FA),
                color: Color(0xFF2B7BE4),
              ),
            ),
          ),
        ),
        TarjetaAzul(
          titulo: 'Mis tareas',
          contenido: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Consultar todas tus tareas'),
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/tareas');
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
            'Matemáticas: Resolver ejercicios de álgebra\nEntrega: Mañana',
          ),
        ),
      ],
    );
  }
}
