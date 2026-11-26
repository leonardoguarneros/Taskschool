import 'package:flutter/material.dart';

class BotonMenu extends StatelessWidget {
  final String texto;
  final IconData icono;

  const BotonMenu({super.key, required this.texto, required this.icono});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$texto: próximamente')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDCE8FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 36, color: const Color(0xFF2B7BE4)),
            const SizedBox(height: 8),
            Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
