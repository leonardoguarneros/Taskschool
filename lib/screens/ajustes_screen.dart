import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'menu_screen.dart';

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Ajustes',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ValueListenableBuilder<ThemeMode>(
          valueListenable: modoTema,
          builder: (context, modo, _) {
            return SwitchListTile(
              secondary: Icon(Icons.dark_mode),
              title: Text('Modo oscuro'),
              value: modo == ThemeMode.dark,
              onChanged: (activado) {
                modoTema.value = activado ? ThemeMode.dark : ThemeMode.light;
              },
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.apps),
          title: Text('Menú'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text('Menú')),
                  body: MenuScreen(),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC62828),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (ruta) => false,
              );
            },
            icon: Icon(Icons.logout),
            label: Text('Cerrar sesión'),
          ),
        ),
      ],
    );
  }
}