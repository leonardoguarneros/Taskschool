import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  Widget campo(String etiqueta, String hint, {bool oculto = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(etiqueta, style: TextStyle(color: Colors.white)),
        SizedBox(height: 4),
        TextField(
          obscureText: oculto,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Registro',
              style: TextStyle(color: Color(0xFF2B7BE4), fontSize: 28),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xFF2B7BE4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  campo('Correo', 'Ejemplo@.com'),
                  campo('Contraseña', '********', oculto: true),
                  campo('Confirmar contraseña', '********', oculto: true),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Crear cuenta'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
