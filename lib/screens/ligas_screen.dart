
import 'package:flutter/material.dart';
import '../colors.dart';
import '../widgets/marco_duolingo.dart';

const _borde = Color(0xFF37464F);
const _gris = Color(0xFFAFAFAF);
const _amarillo = Color(0xFFFFC800);
const _verde = Color(0xFF58CC02);
const _azul = Color(0xFF1CB0F6);

class LigasScreen extends StatefulWidget {
  const LigasScreen({super.key});

  @override
  State<LigasScreen> createState() => _LigasScreenState();
}

class _LigasScreenState extends State<LigasScreen> {
  int _lecciones = 0;
  int _exp = 0;

  bool get _competicionDesbloqueada => _lecciones >= 3;

  Future<void> _iniciarLeccion() async {
    final resultado = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => LeccionScreen(
          numeroLeccion: _lecciones + 1,
        ),
      ),
    );

    if (!mounted || resultado == null) return;

    setState(() {
      _lecciones++;
      _exp += resultado * 10;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Lección completada! +${resultado * 10} EXP',
        ),
        backgroundColor: _verde,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarcoDuolingo(
      menuActual: 2,
      barraInferiorActual: 2,
      centro: _columnaCentral(),
      derecha: [
        _panelInformacion(),
        const SizedBox(height: 20),
        _panelProgreso(),
      ],
    );
  }

  Widget _columnaCentral() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),

        // Escudos de las ligas
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _escudo(Icons.shield_rounded, const Color(0xFFCD9B72), 92),
            const SizedBox(width: 8),
            _escudo(Icons.emoji_events_rounded, _amarillo, 116),
            const SizedBox(width: 8),
            _escudo(Icons.shield_rounded, const Color(0xFFB9D1E0), 92),
          ],
        ),

        const SizedBox(height: 25),

        Text(
          _competicionDesbloqueada
              ? '¡Ya estás en las Ligas!'
              : '¡Compite en las Ligas!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          _competicionDesbloqueada
              ? 'Has completado las lecciones. ¡Ahora puedes competir!'
              : 'Completa ${3 - _lecciones} lecciones más para empezar a competir',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),

        const SizedBox(height: 24),

        // Botón para iniciar una lección
        SizedBox(
          width: 260,
          height: 52,
          child: OutlinedButton(
            onPressed: _iniciarLeccion,
            style: OutlinedButton.styleFrom(
              foregroundColor: _azul,
              side: const BorderSide(color: _borde, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'HAZ UNA LECCIÓN',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ),

        const SizedBox(height: 35),

        // Progreso de las tres lecciones
        _progresoLecciones(),

        const SizedBox(height: 30),

        const Divider(color: _borde, thickness: 2),

        const SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _competicionDesbloqueada
                ? 'Clasificación de la liga'
                : 'Próxima competición',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        const SizedBox(height: 18),

        if (_competicionDesbloqueada)
          _tablaClasificacion()
        else
          _bloqueoLiga(),
      ],
    );
  }

  Widget _escudo(IconData icono, Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.20),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color, width: 4),
      ),
      child: Icon(
        icono,
        color: color,
        size: size * 0.55,
      ),
    );
  }

  Widget _progresoLecciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final completada = index < _lecciones;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Icon(
                  completada
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: completada ? _verde : _gris,
                  size: 36,
                ),
                const SizedBox(height: 8),
                Text(
                  'Lección ${index + 1}',
                  style: TextStyle(
                    color: completada ? _verde : _gris,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _bloqueoLiga() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borde, width: 2),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.lock_rounded,
            color: _gris,
            size: 55,
          ),
          const SizedBox(height: 12),
          const Text(
            'Clasificación bloqueada',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Completa las 3 lecciones para ingresar a la competición.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _gris, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _tablaClasificacion() {
    final jugadores = [
      ['1', 'Sofía', '450 EXP'],
      ['2', 'Daniel', '380 EXP'],
      ['3', 'Carlos', '290 EXP'],
      ['4', 'Tú', '$_exp EXP'],
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borde, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: jugadores.map((jugador) {
          final esUsuario = jugador[1] == 'Tú';

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            decoration: BoxDecoration(
              color: esUsuario
                  ? _azul.withOpacity(0.15)
                  : Colors.transparent,
              border: const Border(
                bottom: BorderSide(color: _borde),
              ),
            ),
            child: Row(
              children: [
                Text(
                  jugador[0],
                  style: const TextStyle(
                    color: _gris,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    jugador[1],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  jugador[2],
                  style: const TextStyle(
                    color: _amarillo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _panelInformacion() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: _borde, width: 2),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¿QUÉ SON LAS LIGAS?',
            style: TextStyle(
              color: _gris,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Completa lecciones, gana EXP y compite',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Gana EXP en tus lecciones y compite con otros usuarios en las Ligas cada semana.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Icon(
              Icons.emoji_events_rounded,
              color: _amarillo,
              size: 65,
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelProgreso() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: _borde, width: 2),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TU PROGRESO',
            style: TextStyle(
              color: _gris,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '$_exp EXP',
            style: const TextStyle(
              color: _amarillo,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_lecciones de 3 lecciones completadas',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: (_lecciones / 3).clamp(0.0, 1.0),
            backgroundColor: _borde,
            color: _verde,
            minHeight: 9,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// PANTALLA DE LECCIONES INTERACTIVAS
// =====================================================

class _Pregunta {
  final String pregunta;
  final List<String> opciones;
  final int correcta;

  const _Pregunta(
    this.pregunta,
    this.opciones,
    this.correcta,
  );
}

class LeccionScreen extends StatefulWidget {
  final int numeroLeccion;

  const LeccionScreen({
    super.key,
    required this.numeroLeccion,
  });

  @override
  State<LeccionScreen> createState() => _LeccionScreenState();
}

class _LeccionScreenState extends State<LeccionScreen> {
  int _indice = 0;
  int _aciertos = 0;
  int? _seleccion;
  bool _respondida = false;

  static const List<_Pregunta> _preguntas = [
    _Pregunta(
      '¿Cómo se dice "Hola" en inglés?',
      ['Goodbye', 'Hello', 'Thanks', 'Please'],
      1,
    ),
    _Pregunta(
      '¿Cuál es la traducción de "Apple"?',
      ['Naranja', 'Uva', 'Manzana', 'Pera'],
      2,
    ),
    _Pregunta(
      'Completa: I ___ a student.',
      ['am', 'is', 'are', 'be'],
      0,
    ),
    _Pregunta(
      '¿Cómo se dice "Gracias" en inglés?',
      ['Sorry', 'Welcome', 'Please', 'Thank you'],
      3,
    ),
    _Pregunta(
      '¿Qué significa "Good morning"?',
      ['Buenas noches', 'Buenos días', 'Buenas tardes', 'Adiós'],
      1,
    ),
  ];

  void _comprobarRespuesta(int opcion) {
    if (_respondida) return;

    setState(() {
      _seleccion = opcion;
      _respondida = true;

      if (opcion == _preguntas[_indice].correcta) {
        _aciertos++;
      }
    });
  }

  void _siguiente() {
    if (_indice < _preguntas.length - 1) {
      setState(() {
        _indice++;
        _seleccion = null;
        _respondida = false;
      });
    } else {
      Navigator.pop(context, _aciertos);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pregunta = _preguntas[_indice];

    return Scaffold(
      backgroundColor: AppColors.fondoOscuro,
      appBar: AppBar(
        backgroundColor: AppColors.fondoOscuro,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lección ${widget.numeroLeccion}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (_indice + 1) / _preguntas.length,
                  backgroundColor: _borde,
                  color: _verde,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                ),

                const SizedBox(height: 35),

                Text(
                  'PREGUNTA ${_indice + 1} DE ${_preguntas.length}',
                  style: const TextStyle(
                    color: _gris,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 22),

                Text(
                  pregunta.pregunta,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 30),

                ...List.generate(pregunta.opciones.length, (index) {
                  final seleccionada = _seleccion == index;
                  final correcta = pregunta.correcta == index;

                  Color fondo = Colors.transparent;
                  Color borde = _borde;

                  if (_respondida && correcta) {
                    fondo = _verde.withOpacity(0.15);
                    borde = _verde;
                  } else if (_respondida && seleccionada) {
                    fondo = Colors.red.withOpacity(0.15);
                    borde = Colors.redAccent;
                  } else if (seleccionada) {
                    fondo = _azul.withOpacity(0.15);
                    borde = _azul;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: _respondida
                          ? null
                          : () => _comprobarRespuesta(index),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: fondo,
                          border: Border.all(color: borde, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                pregunta.opciones[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (_respondida && correcta)
                              const Icon(
                                Icons.check_circle,
                                color: _verde,
                              ),
                            if (_respondida &&
                                seleccionada &&
                                !correcta)
                              const Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                const Spacer(),

                if (_respondida)
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      _seleccion == pregunta.correcta
                          ? '¡Excelente! Respuesta correcta.'
                          : 'Respuesta incorrecta. La correcta es: '
                              '${pregunta.opciones[pregunta.correcta]}',
                      style: TextStyle(
                        color: _seleccion == pregunta.correcta
                            ? _verde
                            : Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _respondida ? _siguiente : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _verde,
                      disabledBackgroundColor: _borde,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _indice == _preguntas.length - 1
                          ? 'TERMINAR LECCIÓN'
                          : 'CONTINUAR',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
