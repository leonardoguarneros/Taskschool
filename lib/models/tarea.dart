class Tarea {
  int? id;
  String titulo;
  String prioridad;
  bool hecha;
  String? fechaLimite;
  String? materia;

  Tarea({
    this.id,
    required this.titulo,
    this.prioridad = 'Media',
    this.hecha = false,
    this.fechaLimite,
    this.materia,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      prioridad: json['prioridad'] as String,
      hecha: json['hecha'] as bool,
      fechaLimite: json['fecha_limite'] as String?,
      materia: json['materia'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'prioridad': prioridad,
      'hecha': hecha,
      'fecha_limite': fechaLimite,
      'materia': materia,
    };
  }
}