import 'package:flutter/material.dart';

class TarjetaAzul extends StatelessWidget {
  final String titulo;
  final Widget contenido;

  const TarjetaAzul({super.key, required this.titulo, required this.contenido});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: Color(0xFF0B2A6F),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          DefaultTextStyle(
            style: TextStyle(color: Colors.black87, fontSize: 14),
            child: contenido,
          ),
        ],
      ),
    );
  }
}
