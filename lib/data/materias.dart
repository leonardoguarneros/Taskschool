import 'package:flutter/material.dart';

class Materia {
  final String nombre;
  final IconData icono;
  const Materia(this.nombre, this.icono);
}

final ValueNotifier<String> nivelActual = ValueNotifier('Primaria');

final Map<String, List<Materia>> materiasPorNivel = {
  'Primaria': [
    Materia('Matemáticas', Icons.calculate),
    Materia('Español', Icons.menu_book),
    Materia('Ciencias', Icons.eco),
    Materia('Historia', Icons.account_balance),
    Materia('Geografía', Icons.public),
    Materia('Inglés', Icons.translate),
    Materia('Ed. Física', Icons.sports_soccer),
    Materia('Artes', Icons.palette),
  ],
  'Secundaria': [
    Materia('Matemáticas', Icons.calculate),
    Materia('Español', Icons.menu_book),
    Materia('Biología', Icons.biotech),
    Materia('Física', Icons.science),
    Materia('Química', Icons.science),
    Materia('Historia', Icons.account_balance),
    Materia('Geografía', Icons.public),
    Materia('Inglés', Icons.translate),
    Materia('Cívica', Icons.groups),
    Materia('Tecnología', Icons.build),
  ],
  'Preparatoria': [
    Materia('Álgebra', Icons.functions),
    Materia('Cálculo', Icons.calculate),
    Materia('Física', Icons.science),
    Materia('Química', Icons.science),
    Materia('Biología', Icons.biotech),
    Materia('Literatura', Icons.menu_book),
    Materia('Historia', Icons.account_balance),
    Materia('Filosofía', Icons.psychology),
    Materia('Inglés', Icons.translate),
    Materia('Informática', Icons.computer),
  ],
  'Universidad': [
    Materia('Programación', Icons.code),
    Materia('Bases de datos', Icons.storage),
    Materia('Redes', Icons.hub),
    Materia('Cálculo', Icons.calculate),
    Materia('Estadística', Icons.bar_chart),
    Materia('Ing. de software', Icons.build),
    Materia('Inteligencia artificial', Icons.smart_toy),
    Materia('Ética profesional', Icons.gavel),
  ],
};
