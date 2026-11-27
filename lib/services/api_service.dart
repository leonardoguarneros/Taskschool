import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/tarea.dart';

class ApiException implements Exception {
  final String mensaje;
  ApiException(this.mensaje);
}

class ApiService {
  static final ApiService instancia = ApiService._();
  ApiService._();

  // Emulador de Android: 10.0.2.2 es tu PC.
  // Celular real: usa la IP de tu PC en el Wi-Fi, por ejemplo http://192.168.1.50:8000
  static const String baseUrl = 'http://10.0.2.2:8000';

  String? _token;

  Map<String, String> get _cabeceras => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  dynamic _json(http.Response r) => jsonDecode(utf8.decode(r.bodyBytes));

  String _mensajeError(http.Response r) {
    try {
      return _json(r)['detail'].toString();
    } catch (_) {
      return 'Error ${r.statusCode}';
    }
  }

  Future<void> _guardarToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    _token = token;
    if (token == null) {
      await prefs.remove('token');
    } else {
      await prefs.setString('token', token);
    }
  }

  Future<void> cargarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }

  bool get haySesion => _token != null;

  // ---------- Usuarios ----------

  Future<void> login(String correo, String password) async {
    final r = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: _cabeceras,
      body: jsonEncode({'correo': correo, 'password': password}),
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
    await _guardarToken(_json(r)['token']);
  }

  Future<void> registro(String correo, String password) async {
    final r = await http.post(
      Uri.parse('$baseUrl/registro'),
      headers: _cabeceras,
      body: jsonEncode({'correo': correo, 'password': password}),
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
    await _guardarToken(_json(r)['token']);
  }

  Future<void> cerrarSesion() => _guardarToken(null);

  // ---------- Tareas ----------

  Future<List<Tarea>> obtenerTareas() async {
    final r = await http.get(Uri.parse('$baseUrl/tareas'), headers: _cabeceras);
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
    final lista = _json(r) as List;
    return lista.map((e) => Tarea.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> insertarTarea(Tarea tarea) async {
    final r = await http.post(
      Uri.parse('$baseUrl/tareas'),
      headers: _cabeceras,
      body: jsonEncode(tarea.toMap()),
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
  }

  Future<void> actualizarTarea(Tarea tarea) async {
    final r = await http.put(
      Uri.parse('$baseUrl/tareas/${tarea.id}'),
      headers: _cabeceras,
      body: jsonEncode(tarea.toMap()),
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
  }

  Future<void> eliminarTarea(int id) async {
    final r = await http.delete(
      Uri.parse('$baseUrl/tareas/$id'),
      headers: _cabeceras,
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
  }

  // ---------- Materias ----------

  Future<Map<String, Set<String>>> obtenerMaterias() async {
    final r = await http.get(
      Uri.parse('$baseUrl/materias'),
      headers: _cabeceras,
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
    final resultado = <String, Set<String>>{};
    for (final fila in _json(r) as List) {
      resultado
          .putIfAbsent(fila['nivel'] as String, () => <String>{})
          .add(fila['materia'] as String);
    }
    return resultado;
  }

  Future<void> marcarMateria(
    String nivel,
    String materia,
    bool completada,
  ) async {
    final r = await http.put(
      Uri.parse('$baseUrl/materias'),
      headers: _cabeceras,
      body: jsonEncode({
        'nivel': nivel,
        'materia': materia,
        'completada': completada,
      }),
    );
    if (r.statusCode != 200) throw ApiException(_mensajeError(r));
  }
}
