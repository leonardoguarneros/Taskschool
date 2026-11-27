import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tarea.dart';

class DbHelper {
  static final DbHelper instancia = DbHelper._();
  DbHelper._();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _abrir();
    return _db!;
  }

  Future<Database> _abrir() async {
    final ruta = join(await getDatabasesPath(), 'taskschool.db');
    return openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tareas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            prioridad TEXT NOT NULL,
            hecha INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<List<Tarea>> obtenerTareas() async {
    final base = await db;
    final filas = await base.query('tareas', orderBy: 'id');
    return filas.map(Tarea.fromMap).toList();
  }

  Future<int> insertarTarea(Tarea tarea) async {
    final base = await db;
    return base.insert('tareas', tarea.toMap());
  }

  Future<void> actualizarTarea(Tarea tarea) async {
    final base = await db;
    await base.update(
      'tareas',
      tarea.toMap(),
      where: 'id = ?',
      whereArgs: [tarea.id],
    );
  }

  Future<void> eliminarTarea(int id) async {
    final base = await db;
    await base.delete('tareas', where: 'id = ?', whereArgs: [id]);
  }
}
