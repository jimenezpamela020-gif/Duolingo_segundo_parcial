import 'package:flutter/material.dart';
//import '../colors.dart';
import '../widgets/marco_duolingo.dart';

const _borde = Color(0xFF37464F);
const _gris = Color(0xFFAFAFAF);
const _amarillo = Color(0xFFFFC800);
const _verde = Color(0xFF58CC02);
const _azul = Color(0xFF1CB0F6);

class TiendaScreen extends StatefulWidget {
  const TiendaScreen({super.key});

  @override
  State<TiendaScreen> createState() => _TiendaScreenState();
}

class _TiendaScreenState extends State<TiendaScreen> {
  int _gemas = 500;
  int _vidas = 5;

  final Set<String> _comprados = {};

  void _mensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _comprar(String nombre, int precio) {
    if (_comprados.contains(nombre)) {
      _mensaje('Ya tienes este potenciador.');
      return;
    }

    if (_gemas < precio) {
      _mensaje('No tienes suficientes gemas. Necesitas $precio gemas.');
      return;
    }

    setState(() {
      _gemas -= precio;
      _comprados.add(nombre);
    });

    _mensaje('¡Has comprado $nombre correctamente!');
  }

  void _recuperarVidas() {
    if (_vidas == 5) {
      _mensaje('¡Ya tienes todas tus vidas!');
      return;
    }

    if (_gemas < 350) {
      _mensaje('Necesitas 350 gemas para recuperar tus vidas.');
      return;
    }

    setState(() {
      _gemas -= 350;
      _vidas = 5;
    });

    _mensaje('¡Has recuperado todas tus vidas!');
  }

  @override
  Widget build(BuildContext context) {
    return MarcoDuolingo(
      menuActual: 4,
      barraInferiorActual: 2,
      centro: _columnaCentral(),
      derecha: [
        _panelLigas(),
        const SizedBox(height: 20),
        _panelDesafios(),
      ],
    );
  }

  // ================= COLUMNA CENTRAL =================

  Widget _columnaCentral() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bannerSuper(),

        const SizedBox(height: 28),

        _encabezado('Vidas'),

        const SizedBox(height: 14),

        _producto(
          icono: Icons.favorite_rounded,
          color: const Color(0xFFFF4B4B),
          titulo: 'Recupera tus vidas',
          descripcion:
              'Recarga tu set de vidas y aumenta las posibilidades de terminar una lección.',
          precio: 350,
          textoBoton: _vidas == 5 ? 'COMPLETO' : 'RECUPERAR',
          alPulsar: _recuperarVidas,
          deshabilitado: _vidas == 5,
          etiqueta: '$_vidas / 5 vidas',
        ),

        _producto(
          icono: Icons.all_inclusive_rounded,
          color: const Color(0xFF58CC02),
          titulo: 'Vidas ilimitadas',
          descripcion: '¡Con Súper no te quedarás sin vidas!',
          precio: 0,
          textoBoton: _comprados.contains('Vidas ilimitadas')
              ? 'ACTIVADO'
              : 'PRUÉBALO GRATIS',
          alPulsar: () {
            if (_comprados.contains('Vidas ilimitadas')) {
              _mensaje('¡Ya tienes activadas las vidas ilimitadas!');
            } else {
              setState(() {
                _comprados.add('Vidas ilimitadas');
              });
              _mensaje('¡Prueba gratuita activada!');
            }
          },
          esGratis: true,
        ),

        const SizedBox(height: 28),

        _encabezado('Potenciadores'),

        const SizedBox(height: 14),

        _producto(
          icono: Icons.shield_rounded,
          color: _azul,
          titulo: 'Protector de racha',
          descripcion:
              'Te permite mantener tu racha cuando no usas la app por un día.',
          precio: 600,
          textoBoton: _comprados.contains('Protector de racha')
              ? 'COMPRADO'
              : 'OBTENER POR',
          alPulsar: () => _comprar('Protector de racha', 600),
          etiqueta: _comprados.contains('Protector de racha')
              ? '1 / 2 EQUIPADOS'
              : '0 / 2 EQUIPADOS',
          comprado: _comprados.contains('Protector de racha'),
        ),

        _producto(
          icono: Icons.bolt_rounded,
          color: _amarillo,
          titulo: 'Doble EXP',
          descripcion:
              'Duplica los puntos de experiencia que consigues en tus lecciones.',
          precio: 450,
          textoBoton: _comprados.contains('Doble EXP')
              ? 'COMPRADO'
              : 'OBTENER POR',
          alPulsar: () => _comprar('Doble EXP', 450),
          comprado: _comprados.contains('Doble EXP'),
        ),

        _producto(
          icono: Icons.timer_rounded,
          color: const Color(0xFFCE82FF),
          titulo: 'Congelación de racha',
          descripcion:
              'Protege tu racha durante un día si no puedes practicar.',
          precio: 300,
          textoBoton: _comprados.contains('Congelación de racha')
              ? 'COMPRADO'
              : 'OBTENER POR',
          alPulsar: () => _comprar('Congelación de racha', 300),
          comprado: _comprados.contains('Congelación de racha'),
        ),

        const SizedBox(height: 25),

        Center(
          child: Text(
            'Tienes $_gemas gemas disponibles',
            style: const TextStyle(
              color: _gris,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  // ================= BANNER SUPER =================

  Widget _bannerSuper() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF064C48),
            Color(0xFF193A85),
            Color(0xFF512477),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: _azul,
                size: 65,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Empieza ahora con una prueba gratis de 1 mes de Súper',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _azul,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'SUPER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () => _mensaje(
                'La prueba de Súper es una demostración. No hay suscripción real.',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF20205A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'EMPIEZA TU MES GRATIS',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PRODUCTOS =================

  Widget _encabezado(String texto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          texto,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(color: _borde, thickness: 2),
      ],
    );
  }

  Widget _producto({
    required IconData icono,
    required Color color,
    required String titulo,
    required String descripcion,
    required int precio,
    required String textoBoton,
    required VoidCallback alPulsar,
    String? etiqueta,
    bool esGratis = false,
    bool deshabilitado = false,
    bool comprado = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _borde, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 76,
            child: Icon(
              icono,
              color: color,
              size: 58,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                if (etiqueta != null) ...[
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _gris.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      etiqueta,
                      style: const TextStyle(
                        color: _gris,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 7),

                Text(
                  descripcion,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          SizedBox(
            width: 132,
            height: 44,
            child: OutlinedButton(
              onPressed: deshabilitado ? null : alPulsar,
              style: OutlinedButton.styleFrom(
                foregroundColor: esGratis
                    ? const Color(0xFFCE00D9)
                    : comprado
                        ? _verde
                        : _gris,
                disabledForegroundColor: const Color(0xFF607783),
                side: BorderSide(
                  color: deshabilitado ? _borde : _borde,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      textoBoton,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (!esGratis &&
                        !deshabilitado &&
                        !comprado) ...[
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.hexagon_rounded,
                        color: _azul,
                        size: 19,
                      ),
                      Text(
                        '$precio',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PANEL DERECHO =================

  Widget _panelLigas() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: _borde, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¡Compite en las Ligas!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Icon(
                Icons.shield_rounded,
                color: _azul,
                size: 42,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  'Completa 3 lecciones más para empezar a competir.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _panelDesafios() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: _borde, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Desafíos del día',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              TextButton(
                onPressed: () => _mensaje('Próximamente: todos los desafíos.'),
                child: const Text(
                  'VER TODOS',
                  style: TextStyle(
                    color: _azul,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(
                Icons.bolt_rounded,
                color: _amarillo,
                size: 43,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gana 10 EXP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0,
                      minHeight: 9,
                      backgroundColor: _borde,
                      color: _verde,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '0 / 10',
                      style: TextStyle(
                        color: _gris,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.inventory_2_rounded,
                color: Color(0xFFFF9600),
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
