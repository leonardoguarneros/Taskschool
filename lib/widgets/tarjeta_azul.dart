import 'package:flutter/material.dart';

class TarjetaAzul extends StatelessWidget {
  final String titulo;
  final Widget contenido;

  const TarjetaAzul({super.key, required this.titulo, required this.contenido});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      color: Color(0xFF2B7BE4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          contenido,
        ],
      ),
    );
  }
}
