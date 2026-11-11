import 'package:flutter/material.dart';
import '../colors.dart';
import '../widgets/marco_duolingo.dart';

const _borde = Color(0xFF37464F);
const _gris = Color(0xFFAFAFAF);
const _naranja = Color(0xFFFF9600);
const _amarillo = Color(0xFFFFC800);

class MisionesScreen extends StatefulWidget {
  const MisionesScreen({super.key});

  @override
  State<MisionesScreen> createState() => _MisionesScreenState();
}

class _MisionesScreenState extends State<MisionesScreen> {
  int xpActual = 0;
  final int xpMeta = 10;

  void incrementarXp() {
    setState(() {
      if (xpActual < xpMeta) {
        xpActual += 2;
      } else {
        xpActual = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MarcoDuolingo(
      menuActual: 3, // DESAFÍOS
      barraInferiorActual: 1,
      centro: _columnaCentral(),
      derecha: [_panelMensual()],
    );
  }

  // ───────────────────────── CENTRO ─────────────────────────

  Widget _columnaCentral() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _banner(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Desafíos del día',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: const [
                Icon(Icons.schedule_rounded, color: _naranja, size: 20),
                SizedBox(width: 6),
                Text(
                  '7 HORAS',
                  style: TextStyle(
                    color: _naranja,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _tarjetaDesafio(),
        const SizedBox(height: 16),
        _tarjetaBloqueada(),
      ],
    );
  }

  Widget _banner() {
    return Container(
      width: double.infinity,
      height: 260,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.morado,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola de nuevo!',
                  style: TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Completa desafíos y recibe recompensas',
                  style: TextStyle(color: Color(0xFF1F1F1F), fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(Icons.auto_awesome, color: Colors.white, size: 30),
                Text('🦉', style: TextStyle(fontSize: 96)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaDesafio() {
    final progreso = (xpActual / xpMeta).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borde, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt, color: _amarillo, size: 52),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gana 10 EXP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: LinearProgressIndicator(
                                  value: progreso,
                                  minHeight: 22,
                                  backgroundColor: _borde,
                                  color: _amarillo,
                                ),
                              ),
                              Text(
                                '$xpActual / $xpMeta',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.inventory_2_rounded,
                            color: _naranja, size: 34),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: incrementarXp,
              child: Text(
                'SIMULAR AVANCE',
                style: TextStyle(
                  color: AppColors.morado,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaBloqueada() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        color: const Color(0xFF202F36),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borde, width: 2),
      ),
      child: Row(
        children: const [
          Icon(Icons.lock_rounded, color: _gris, size: 44),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              'Estamos preparando más desafíos',
              style: TextStyle(
                color: Color(0xFF5B707C),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── DERECHA ─────────────────────────

  Widget _panelMensual() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borde, width: 2),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Los desafíos del mes empezarán pronto!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Completa el desafío de cada mes y recibe medallas exclusivas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Medalla
              Container(
                width: 84,
                height: 84,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _amarillo,
                ),
                child: const Icon(Icons.bolt, color: _naranja, size: 52),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: _borde, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              child: Text(
                'HAZ UNA LECCIÓN',
                style: TextStyle(
                  color: AppColors.azul,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}