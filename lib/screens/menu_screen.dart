import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget botonMenu(BuildContext context, String texto, IconData icono) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$texto: próximamente')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFDCE8FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 36, color: Color(0xFF2B7BE4)),
            SizedBox(height: 8),
            Text(texto, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Menú',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            botonMenu(context, 'Servicios', Icons.menu_book),
            botonMenu(context, 'Ubicaciones', Icons.location_on),
            botonMenu(context, 'Personal', Icons.people),
            botonMenu(context, 'Notificación', Icons.notifications),
          ],
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: botonMenu(context, 'Galería', Icons.image),
        ),
      ],
    );
  }
}
