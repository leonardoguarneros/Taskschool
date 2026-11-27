import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final correoCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool ocultar = true;

  @override
  void dispose() {
    correoCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  InputDecoration decoracion(String hint, IconData icono, {Widget? sufijo}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black45),
      prefixIcon: Icon(icono, color: Color(0xFF0B2A6F)),
      suffixIcon: sufijo,
      filled: true,
      fillColor: Colors.white,
      errorStyle: TextStyle(color: Color(0xFFFFB4B4)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void iniciarSesion() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/principal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B2A6F),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Icon(Icons.auto_stories, size: 72, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'TaskSchool',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Organiza tus tareas escolares',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 32),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: correoCtrl,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black87),
                    decoration:
                        decoracion('Correo electrónico', Icons.email_outlined),
                    validator: (valor) {
                      final texto = valor?.trim() ?? '';
                      if (texto.isEmpty) return 'Escribe tu correo';
                      final formato = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!formato.hasMatch(texto)) return 'Correo no válido';
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: passCtrl,
                    obscureText: ocultar,
                    style: TextStyle(color: Colors.black87),
                    decoration: decoracion(
                      'Contraseña',
                      Icons.lock_outline,
                      sufijo: IconButton(
                        icon: Icon(
                          ocultar ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF0B2A6F),
                        ),
                        onPressed: () {
                          setState(() {
                            ocultar = !ocultar;
                          });
                        },
                      ),
                    ),
                    validator: (valor) {
                      final texto = valor ?? '';
                      if (texto.isEmpty) return 'Escribe tu contraseña';
                      if (texto.length < 6) return 'Mínimo 6 caracteres';
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2B7BE4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: iniciarSesion,
                      child: Text('Iniciar sesión'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registro');
                    },
                    child: Text(
                      '¿No tienes cuenta? Regístrate',
                      style: TextStyle(color: Colors.white),
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