class Clase {
  int? id;
  int dia;
  String hora;
  String materia;

  Clase({
    this.id,
    required this.dia,
    required this.hora,
    required this.materia,
  });

  factory Clase.fromJson(Map<String, dynamic> json) {
    return Clase(
      id: json['id'] as int,
      dia: json['dia'] as int,
      hora: json['hora'] as String,
      materia: json['materia'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'dia': dia, 'hora': hora, 'materia': materia};
  }
}
