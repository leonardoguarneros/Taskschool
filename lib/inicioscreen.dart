import 'package:flutter/material.dart';
import '../widgets/tarjeta_azul.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

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
              Text('Ejercicios Matemáticas   Hoy 16:00',
                  style: TextStyle(color: Colors.white)),
              Text('Leer cap.7 Álgebra II   Hoy 16:30',
                  style: TextStyle(color: Colors.white)),
              Text('Leer cap.3 Historia   Hoy 18:00',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}