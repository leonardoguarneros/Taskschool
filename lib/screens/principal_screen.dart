import 'package:flutter/material.dart';

class MateriasScreen extends StatelessWidget {
  const MateriasScreen({super.key});

  Widget tarjetaMateria(String nombre, IconData icono, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 36, color: Color(0xFF0B2A6F)),
          SizedBox(height: 8),
          Text(nombre, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        GridView.extent(
          maxCrossAxisExtent: 140,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            tarjetaMateria('Matemáticas', Icons.calculate, Color(0xFFDCE8FA)),
            tarjetaMateria('Física', Icons.science, Color(0xFFFADCE8)),
            tarjetaMateria(
              'Historia',
              Icons.account_balance,
              Color(0xFFFAE8DC),
            ),
            tarjetaMateria('Literatura', Icons.menu_book, Color(0xFFFAE8DC)),
            tarjetaMateria('Ciencias', Icons.eco, Color(0xFFDCFAE8)),
            tarjetaMateria('Informática', Icons.computer, Color(0xFFDCE8FA)),
          ],
        ),
        SizedBox(height: 24),
        Text(
          'Resumen',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: 0.75,
                      strokeWidth: 8,
                      backgroundColor: Color(0xFFDCE8FA),
                      color: Color(0xFF2B7BE4),
                    ),
                  ),
                  Text(
                    '75%',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Text(
              'Materias\ncompletadas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
