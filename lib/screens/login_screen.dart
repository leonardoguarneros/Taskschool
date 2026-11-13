import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TaskSchool',
              style: TextStyle(
                color: Color(0xFF2B7BE4),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Organiza tus tareas escolares'),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B7BE4),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/principal');
              },
              child: Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registro');
              },
              child: Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
