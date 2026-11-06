import 'package:flutter/material.dart';
import '../colors.dart';
import '../screens/home_screen.dart';
import '../screens/pantalla_adicional_1.dart';
import '../screens/pantalla_adicional_2.dart';

class BarraInferior extends StatelessWidget {
  final int actual;

  const BarraInferior({super.key, required this.actual});

  void _ir(BuildContext context, int indice) {
    if (indice == actual) return;
    final pantallas = <Widget>[
      const HomeScreen(),
      const MisionesScreen(),
      const PerfilScreen(),
    ];
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => pantallas[indice]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: actual,
      onTap: (i) => _ir(context, i),
      backgroundColor: AppColors.fondoOscuro,
      selectedItemColor: AppColors.azul,
      unselectedItemColor: Colors.white54,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_rounded), label: 'Misiones'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded), label: 'Perfil'),
      ],
    );
  }
}
