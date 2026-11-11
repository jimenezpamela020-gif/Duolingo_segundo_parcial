import 'package:flutter/material.dart';

import '../widgets/marco_duolingo.dart';
import 'ligas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _mostrarGuia = false;
  bool _mostrarPopupLeccion = false;
  int _leccionesCompletadas = 0;
  final int _experienciaTotal = 0;
  bool _isOpening = false;
 
 Future<void> _iniciarLeccionHome() async {
  if (_isOpening) return; 
  
  setState(() {
    _isOpening = true; 
    _mostrarPopupLeccion = false;
  });

  final resultado = await Navigator.push<int>(
    context,
    MaterialPageRoute(
      builder: (_) => 
        LeccionFrancesScreen(numeroLeccion: _leccionesCompletadas + 1),
    ),
  );

  if (!mounted) return;
  
  setState(() {
    _isOpening = false; 
  });

  if (resultado == null) return;

  setState(() {
    _leccionesCompletadas = resultado;
  });


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Lección de unidad completada! +${resultado * 10} EXP',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF58CC02),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarcoDuolingo(
      menuActual: 0,
      barraInferiorActual: 0,
      centro: _mostrarGuia ? _buildVistaGuia() : _buildVistaCamino(),
      derecha: [
        _buildRightCard(
          title: 'Prueba Súper gratis',
          subtitle: 'Sin anuncios, con prácticas personalizadas y sin límites para el nivel Legendario.',
          buttonText: 'EMPIEZA TU MES GRATIS',
          buttonColor: const Color(0xFF1CB0F6),
          onTapButton: () {
            _mostrarMensaje(
              context,
              'Abriendo prueba gratuita de Super Duolingo...',
            );
          },
        ),
        const SizedBox(height: 16),
        _buildRightCard(
          title: 'División Oro',
          subtitle:
              'Progreso actual: $_leccionesCompletadas lecciones | $_experienciaTotal EXP',
          actionText: 'VER LIGAS',
          onTapAction: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LigasScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildRightCard(
          title: 'Desafíos del día',
          subtitle: 'Gana 10 EXP completando lecciones diarias',
          actionText: 'VER TODOS',
          onTapAction: () {
            _mostrarMensaje(context, 'Mostrando todos los desafíos diarios...');
          },
        ),
      ],
    );
  }

  Widget _buildVistaCamino() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner de Unidad Violeta
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: const Color(0xFFCE82FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '← ETAPA 1, SECCIÓN 2',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Saluda y preséntate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _mostrarGuia = true;
                      });
                    },
                    icon: const Icon(Icons.book, size: 18),
                    label: const Text('GUÍA'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            
            Center(
              child: SizedBox(
                width: 380,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 10,
                      top: 15,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF1C2C35,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF37464F),
                            width: 1.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/Buho_durmiendo.png',
                          width: 80,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.bedtime,
                                size: 50,
                                color: Color(0xFF58CC02),
                              ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        _buildPathNode(
                          icon: Icons.star,
                          offset: 40.0,
                          isActive: true,
                          label: 'EMPEZAR',
                          onTap: () {
                            setState(() {
                              _mostrarPopupLeccion = !_mostrarPopupLeccion;
                            });
                          },
                        ),
                        _buildPathNode(
                          icon: Icons.lock,
                          offset: 90.0,
                          isLocked: true,
                        ),
                        _buildPathNode(
                          icon: Icons.lock,
                          offset: 20.0,
                          isLocked: true,
                        ),
                        _buildPathNode(
                          icon: Icons.lock,
                          offset: 50.0,
                          isLocked: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        
        if (_mostrarPopupLeccion)
          Positioned(
            top: 150,
            left: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFCE82FF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saluda y preséntate',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lección ${_leccionesCompletadas + 1} de 4',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _iniciarLeccionHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFCE82FF),
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'EMPEZAR +30 EXP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildVistaGuia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () {
            setState(() {
              _mostrarGuia = false;
            });
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: const Text(
            'Regresar al Camino',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Guía de la Sección 2',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aprende tips de gramática y frases clave para presentarte.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 24),
        _buildFraseClaveCard(
          'Bonjour, je m\'appelle Marie.',
          'Hola, me llamo Marie.',
        ),
        const SizedBox(height: 12),
        _buildFraseClaveCard(
          'Enchanté, comment ça va ?',
          'Mucho gusto, ¿cómo estás?',
        ),
      ],
    );
  }

  Widget _buildFraseClaveCard(String frase, String traduccion) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF182026),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF37464F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            frase,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            traduccion,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildPathNode({
    required IconData icon,
    double offset = 0.0,
    bool isActive = false,
    bool isLocked = false,
    String? label,
    VoidCallback? onTap,
  }) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            if (label != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFCE82FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? const Color(0xFFCE82FF)
                      : const Color(0xFF202F36),
                  boxShadow: [
                    BoxShadow(
                      color: isActive
                          ? const Color(0xFFA559D6)
                          : const Color(0xFF131F24),
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  isLocked ? Icons.lock : icon,
                  color: isActive ? Colors.white : Colors.grey[600],
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightCard({
    required String title,
    required String subtitle,
    String? buttonText,
    Color? buttonColor,
    String? actionText,
    VoidCallback? onTapButton,
    VoidCallback? onTapAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF182026),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF37464F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              if (actionText != null)
                InkWell(
                  onTap: onTapAction,
                  child: Text(
                    actionText,
                    style: const TextStyle(
                      color: Color(0xFF1CB0F6),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          if (buttonText != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTapButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _mostrarMensaje(BuildContext context, String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF202F36),
      ),
    );
  }
}

class _PreguntaFrances {
  final String pregunta;
  final List<String> opciones;
  final int correcta;

  const _PreguntaFrances(this.pregunta, this.opciones, this.correcta);
}

class LeccionFrancesScreen extends StatefulWidget {
  final int numeroLeccion;

  const LeccionFrancesScreen({super.key, required this.numeroLeccion});

  @override
  State<LeccionFrancesScreen> createState() => _LeccionFrancesScreenState();
}

class _LeccionFrancesScreenState extends State<LeccionFrancesScreen> {
  int _indice = 0;
  int _aciertos = 0;
  int? _seleccion;
  bool _respondida = false;

  static const List<_PreguntaFrances> _preguntas = [
    _PreguntaFrances('¿Cómo se dice "Hola, me llamo Marie" en francés?', [
      'Bonjour, je m\'appelle Marie.',
      'Au revoir, merci.',
      'Comment ça va?',
      'Enchanté.',
    ], 0),
    _PreguntaFrances('¿Qué significa "Enchanté"?', [
      'Adiós',
      'Buenos días',
      'Mucho gusto',
      'Gracias',
    ], 2),
    _PreguntaFrances('Completa la frase: "Comment ___ tu ?"', [
      'es',
      'ça va',
      'appelle',
      'suis',
    ], 1),
    _PreguntaFrances('¿Cómo se traduce "Mucho gusto"?', [
      'Bonjour',
      'Enchanté',
      'Salut',
      'Pardon',
    ], 1),
  ];

  void _comprobar(int opcion) {
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
    const borde = Color(0xFF37464F);
    const verde = Color(0xFF58CC02);
    const azul = Color(0xFF1CB0F6);

    return Scaffold(
      backgroundColor: const Color(0xFF131F24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131F24),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lección de Unidad ${widget.numeroLeccion}',
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
                  backgroundColor: borde,
                  color: verde,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 35),
                Text(
                  'PREGUNTA ${_indice + 1} DE ${_preguntas.length}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  pregunta.pregunta,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 30),
                ...List.generate(pregunta.opciones.length, (index) {
                  final seleccionada = _seleccion == index;
                  final correcta = pregunta.correcta == index;

                  Color fondo = Colors.transparent;
                  Color colBorde = borde;

                  if (_respondida && correcta) {
                    fondo = verde.withValues(alpha: 0.15);
                    colBorde = verde;
                  } else if (_respondida && seleccionada) {
                    fondo = Colors.red.withValues(alpha: 0.15);
                    colBorde = Colors.redAccent;
                  } else if (seleccionada) {
                    fondo = azul.withValues(alpha: 0.15);
                    colBorde = azul;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: _respondida ? null : () => _comprobar(index),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: fondo,
                          border: Border.all(color: colBorde, width: 2),
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
                              const Icon(Icons.check_circle, color: verde),
                            if (_respondida && seleccionada && !correcta)
                              const Icon(Icons.cancel, color: Colors.redAccent),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const Spacer(),
                if (_respondida)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _seleccion == pregunta.correcta
                          ? '¡Excelente! Respuesta correcta.'
                          : 'Incorrecto. La respuesta es: ${pregunta.opciones[pregunta.correcta]}',
                      style: TextStyle(
                        color: _seleccion == pregunta.correcta
                            ? verde
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
                      backgroundColor: verde,
                      disabledBackgroundColor: borde,
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
