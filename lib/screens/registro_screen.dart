import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  Widget campo(
    String etiqueta,
    String hint,
    IconData icono, {
    bool oculto = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: TextStyle(
            color: Color(0xFF0B2A6F),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        TextField(
          obscureText: oculto,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icono, color: Color(0xFF2B7BE4)),
            filled: true,
            fillColor: Color(0xFFDCE8FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF0B2A6F),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Icon(Icons.auto_stories, size: 64, color: Color(0xFF2B7BE4)),
                  SizedBox(height: 8),
                  Text(
                    'Registro',
                    style: TextStyle(
                      color: Color(0xFF0B2A6F),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  campo('Correo', 'Ejemplo@correo.com', Icons.email_outlined),
                  campo(
                    'Contraseña',
                    '********',
                    Icons.lock_outline,
                    oculto: true,
                  ),
                  campo(
                    'Confirmar contraseña',
                    '********',
                    Icons.lock_outline,
                    oculto: true,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0B2A6F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Crear cuenta'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
