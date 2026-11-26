import 'package:flutter/material.dart';

import '../widgets/boton_menu.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Menú',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            BotonMenu(texto: 'Servicios', icono: Icons.menu_book),
            BotonMenu(texto: 'Ubicaciones', icono: Icons.location_on),
            BotonMenu(texto: 'Personal', icono: Icons.people),
            BotonMenu(texto: 'Notificación', icono: Icons.notifications),
          ],
        ),
        const SizedBox(height: 12),
        const SizedBox(
          height: 110,
          child: BotonMenu(texto: 'Galería', icono: Icons.image),
        ),
      ],
    );
  }
}
