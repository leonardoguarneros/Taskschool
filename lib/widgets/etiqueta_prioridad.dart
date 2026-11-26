import 'package:flutter/material.dart';

class EtiquetaPrioridad extends StatelessWidget {
  final String prioridad;

  const EtiquetaPrioridad({super.key, required this.prioridad});

  @override
  Widget build(BuildContext context) {
    final bool esAlta = prioridad == 'Alta';
    final Color fondo = esAlta ? Color(0xFFFFD6D6) : Color(0xFFFFF0B8);
    final Color texto = esAlta ? Color(0xFFC62828) : Color(0xFF8A6D00);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        prioridad,
        style: TextStyle(
          color: texto,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
