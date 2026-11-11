import 'package:flutter/material.dart';

import '../colors.dart';
import '../screens/home_screen.dart';
import '../screens/pantalla_adicional_1.dart';
import '../screens/pantalla_adicional_2.dart';
import '../screens/ligas_screen.dart';
import '../screens/tienda_screen.dart';

const _borde = Color(0xFF37464F);
const _gris = Color(0xFFAFAFAF);

class _ItemMenu {
  final IconData icono;
  final Color color;
  final String titulo;
  const _ItemMenu(this.icono, this.color, this.titulo);
}

/// Barra lateral de Duolingo 
class BarraLateral extends StatelessWidget {
  final int actual;

  const BarraLateral({super.key, this.actual = 5});

  static const _items = [
    _ItemMenu(Icons.home_rounded, Color(0xFFFF9600), 'APRENDER'),
    _ItemMenu(Icons.fitness_center, Color(0xFF1CB0F6), 'PRACTICAR'),
    _ItemMenu(Icons.shield_rounded, Color(0xFFFFC800), 'LIGAS'),
    _ItemMenu(Icons.inventory_2_rounded, Color(0xFFFF9600), 'DESAFÍOS'),
    _ItemMenu(Icons.storefront_rounded, Color(0xFFFF4B4B), 'TIENDA'),
    _ItemMenu(Icons.account_circle_outlined, Color(0xFF1CB0F6), 'PERFIL'),
    _ItemMenu(Icons.more_horiz_rounded, Color(0xFFCE82FF), 'MÁS'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: AppColors.fondoOscuro,
        border: Border(right: BorderSide(color: _borde, width: 2)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 24),
              child: Text(
                'duolingo',
                style: TextStyle(
                  color: Color(0xFF58CC02),
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
            ),
            for (int i = 0; i < _items.length; i++) _itemMenu(context, i),
            const SizedBox(height: 20),
            _tarjetaAjedrez(),
          ],
        ),
      ),
    );
  }

  void _ir(BuildContext context, int index) {
    if (index == actual) return;

    Widget? destino;
    switch (index) {
      case 0: 
        destino = const HomeScreen();
        break;
      case 2:
        destino = const LigasScreen();
        break;
      case 3:
        destino = const MisionesScreen();
        break;
      case 4:
        destino = const TiendaScreen();
        break;
      case 5:
        destino = const PerfilScreen();
        break;
    }

    if (destino == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_items[index].titulo}: próximamente')),
      );
      return;
    }

    final pantalla = destino;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pantalla,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  Widget _itemMenu(BuildContext context, int index) {
    final item = _items[index];
    final seleccionado = index == actual;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _ir(context, index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: seleccionado
                ? AppColors.azul.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: seleccionado ? AppColors.azul : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(item.icono, color: item.color, size: 30),
              const SizedBox(width: 18),
              Text(
                item.titulo,
                style: TextStyle(
                  color: seleccionado ? AppColors.azul : Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tarjetaAjedrez() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borde, width: 2),
      ),
      child: Column(
        children: [
          const Icon(Icons.extension_rounded, color: _gris, size: 36),
          const SizedBox(height: 10),
          const Text(
            '¿Quieres aprender ajedrez?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '¡Duolingo hace que sea fácil!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Text(
            'PRUEBA AJEDREZ',
            style: TextStyle(
              color: AppColors.azul,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
