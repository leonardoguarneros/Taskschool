class Tarea {
  final int? id;
  final String titulo;
  final String prioridad;
  final bool hecha;

  Tarea({
    this.id,
    required this.titulo,
    required this.prioridad,
    this.hecha = false,
  });

  factory Tarea.fromMap(Map<String, dynamic> m) => Tarea(
    id: m['id'] as int?,
    titulo: m['titulo'] as String,
    prioridad: m['prioridad'] as String,
    hecha: (m['hecha'] as int) == 1,
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'titulo': titulo,
    'prioridad': prioridad,
    'hecha': hecha ? 1 : 0,
  };
}
