import 'package:flutter/material.dart';
import '../colors.dart';
import '../screens/home_screen.dart';
import '../screens/pantalla_adicional_1.dart';
import '../screens/pantalla_adicional_2.dart';

class BarraInferior extends StatelessWidget {
  final int actual;

  const BarraInferior({super.key, required this.actual});

  void irA(BuildContext context, int indice) {
    if (indice == actual) return;

    Widget pantalla;
    if (indice == 0) {
      pantalla = const HomeScreen();
    } else if (indice == 1) {
      pantalla = const MisionesScreen();
    } else {
      pantalla = const PerfilScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pantalla),
    );
  }

  Widget crearBoton(
      BuildContext context, int indice, IconData icono, Color color) {
    bool seleccionado = indice == actual;

    return GestureDetector(
      onTap: () {
        irA(context, indice);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: seleccionado ? const Color(0xFFDDF4FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: seleccionado ? const Color(0xFF84D8FF) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Icon(icono, size: 32, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5), width: 2),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              crearBoton(context, 0, Icons.home_rounded, Colors.orange),
              crearBoton(
                  context, 1, Icons.inventory_2_rounded, AppColors.amarillo),
              crearBoton(context, 2, Icons.person_rounded, AppColors.morado),
            ],
          ),
        ),
      ),
    );
  }
}
