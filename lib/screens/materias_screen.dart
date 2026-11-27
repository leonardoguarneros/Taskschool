import 'package:flutter/material.dart';

class Materia {
  final String nombre;
  final IconData icono;
  const Materia(this.nombre, this.icono);
}

class MateriasScreen extends StatefulWidget {
  const MateriasScreen({super.key});

  @override
  State<MateriasScreen> createState() => _MateriasScreenState();
}

class _MateriasScreenState extends State<MateriasScreen> {
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

  final List<Color> colores = [
    Color(0xFFDCE8FA),
    Color(0xFFFADCE8),
    Color(0xFFFAE8DC),
    Color(0xFFDCFAE8),
  ];

  late final Map<String, Set<String>> completadas = {
    for (final nivel in materiasPorNivel.keys) nivel: <String>{},
  };

  String nivel = 'Primaria';

  double progresoDe(String n) {
    final total = materiasPorNivel[n]!.length;
    return completadas[n]!.length / total;
  }

  void alternar(Materia materia) {
    setState(() {
      final set = completadas[nivel]!;
      if (set.contains(materia.nombre)) {
        set.remove(materia.nombre);
      } else {
        set.add(materia.nombre);
      }
    });
  }

  Widget tarjetaMateria(Materia materia, int i) {
    final hecha = completadas[nivel]!.contains(materia.nombre);

    return GestureDetector(
      onTap: () => alternar(materia),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: hecha ? Color(0xFFBFEBCB) : colores[i % colores.length],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hecha ? Color(0xFF2E9E57) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(materia.icono, size: 32, color: Color(0xFF0B2A6F)),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      materia.nombre,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF0B2A6F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (hecha)
              Positioned(
                top: 6,
                right: 6,
                child: Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Color(0xFF2E9E57),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final materias = materiasPorNivel[nivel]!;
    final progreso = progresoDe(nivel);
    final hechas = completadas[nivel]!.length;

    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        Text(
          'Materias',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: materiasPorNivel.keys.map((n) {
            return ChoiceChip(
              label: Text(n),
              selected: n == nivel,
              onSelected: (_) {
                setState(() {
                  nivel = n;
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 12),
        Text('Toca una materia para marcarla como completada'),
        SizedBox(height: 12),
        GridView.extent(
          maxCrossAxisExtent: 130,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0; i < materias.length; i++)
              tarjetaMateria(materias[i], i),
          ],
        ),
        SizedBox(height: 24),
        Text(
          'Resumen de $nivel',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progreso),
                duration: Duration(milliseconds: 500),
                builder: (context, valor, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: valor,
                          strokeWidth: 8,
                          backgroundColor: Color(0xFFDCE8FA),
                          color: Color(0xFF2B7BE4),
                        ),
                      ),
                      Text(
                        '${(progreso * 100).round()}%',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                '$hechas de ${materias.length} materias completadas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        for (final n in materiasPorNivel.keys)
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(n),
                    Text('${(progresoDe(n) * 100).round()}%'),
                  ],
                ),
                SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progresoDe(n),
                    minHeight: 8,
                    backgroundColor: Color(0xFFDCE8FA),
                    color: Color(0xFF2B7BE4),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
