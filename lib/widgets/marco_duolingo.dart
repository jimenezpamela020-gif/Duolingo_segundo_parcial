import 'package:flutter/material.dart';
import '../colors.dart';
import 'barra_inferior.dart';
import 'barra_lateral.dart';

const _gris = Color(0xFFAFAFAF);

class MarcoDuolingo extends StatelessWidget {
  
  final int menuActual;

  final int barraInferiorActual;

  final Widget centro;

  final List<Widget> derecha;

  const MarcoDuolingo({
    super.key,
    required this.menuActual,
    required this.barraInferiorActual,
    required this.centro,
    this.derecha = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth >= 900;

        if (!ancho) {
          return Scaffold(
            backgroundColor: AppColors.fondoOscuro,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _BarraStats(),
                    const SizedBox(height: 16),
                    centro,
                    const SizedBox(height: 24),
                    ...derecha,
                    const SizedBox(height: 24),
                    const _PieLinks(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar:
                BarraInferior(actual: barraInferiorActual),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.fondoOscuro,
          body: Row(
            children: [
              BarraLateral(actual: menuActual),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: centro,
                          ),
                        ),
                        SizedBox(
                          width: 380,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _BarraStats(),
                                const SizedBox(height: 24),
                                ...derecha,
                                const SizedBox(height: 24),
                                const _PieLinks(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BarraStats extends StatelessWidget {
  const _BarraStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('🇫🇷', style: TextStyle(fontSize: 26)),
        _contador(Icons.local_fire_department, '0', _gris.withValues(alpha: 0.5)),
        _contador(Icons.diamond_rounded, '1029', AppColors.azul),
        _contador(Icons.favorite_rounded, '5', const Color(0xFFFF4B4B)),
      ],
    );
  }

  Widget _contador(IconData icono, String valor, Color color) {
    return Row(
      children: [
        Icon(icono, color: color, size: 26),
        const SizedBox(width: 6),
        Text(
          valor,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w800, fontSize: 15),
        ),
      ],
    );
  }
}

class _PieLinks extends StatelessWidget {
  const _PieLinks();

  @override
  Widget build(BuildContext context) {
    const links = [
      'ACERCA DE',
      'BLOG',
      'TIENDA',
      'EFICACIA',
      'EMPLEO',
      'INVERSIONISTAS',
      'TÉRMINOS',
      'PRIVACIDAD',
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 18,
      runSpacing: 10,
      children: [
        for (final l in links)
          Text(
            l,
            style: const TextStyle(
              color: _gris,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
      ],
    );
  }
}