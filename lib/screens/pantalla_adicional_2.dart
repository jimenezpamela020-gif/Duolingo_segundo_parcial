import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../colors.dart';
import '../widgets/marco_duolingo.dart';
import 'login_screen.dart'; 

const _borde = Color(0xFF37464F);
const _gris = Color(0xFFAFAFAF);
const _bannerFondo = Color(0xFF202F36);

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  int _tabAmigos = 0;

  // FOTO DE PERFIL
  Uint8List? _fotoPerfil;

  final ImagePicker _selectorImagen = ImagePicker();

  // SELECCIONAR FOTO DESDE EL DISPOSITIVO
  Future<void> _seleccionarFoto() async {
    try {
      final XFile? imagen = await _selectorImagen.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (imagen == null) return;

      final bytes = await imagen.readAsBytes();

      if (!mounted) return;

      setState(() {
        _fotoPerfil = bytes;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Foto de perfil actualizada correctamente!'),
          backgroundColor: Color(0xFF58CC02),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al seleccionar la foto: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MarcoDuolingo(
      menuActual: 5,
      barraInferiorActual: 2,
      centro: _columnaCentral(),
      derecha: [
        _panelAmigos(),
        const SizedBox(height: 20),
        _agregarAmigos(),
      ],
    );
  }

  // ───────────────────────── COLUMNA CENTRAL ─────────────────────────

  Widget _columnaCentral() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _banner(),

        const SizedBox(height: 20),

        const Text(
          'Pamela Jimenez',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 2),

        const Text(
          'PamelaJime169941',
          style: TextStyle(color: _gris, fontSize: 16),
        ),

        const SizedBox(height: 4),

        const Text(
          'Se unió en octubre de 2021',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Text(
              'Siguiendo a 0',
              style: TextStyle(
                color: AppColors.azul,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),

            const SizedBox(width: 16),

            Text(
              '0 seguidores',
              style: TextStyle(
                color: AppColors.azul,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),

            const Spacer(),

            const Text(
              '🇺🇸 🇫🇷 🇩🇪 🇮🇹',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const Divider(color: _borde, thickness: 2),

        const SizedBox(height: 20),

        const Text(
          'Estadísticas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _tarjetaEstadistica(
                Icons.local_fire_department,
                '0',
                'días de racha',
                _gris.withValues(alpha: 0.5),
                apagada: true,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _tarjetaEstadistica(
                Icons.bolt,
                '973',
                'EXP totales',
                const Color(0xFFFFC800),
              ),
            ),
          ],
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            Expanded(
              child: _tarjetaEstadistica(
                Icons.shield_rounded,
                'Oro',
                'división actual',
                const Color(0xFFFFC800),
                etiqueta: '1 SEMANA',
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _tarjetaEstadistica(
                Icons.emoji_events_rounded,
                '1',
                'veces en el top 3',
                const Color(0xFFFFC800),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Logros',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),

            TextButton(
              onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Mostrando todos los logros...')),
  );
},
              child: Text(
                'VER TODOS',
                style: TextStyle(
                  color: AppColors.azul,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // BOTÓN CERRAR SESIÓN (CORREGIDO PARA IR AL LOGIN)
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rojo,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, 
              );
            },
            child: const Text(
              'CERRAR SESIÓN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

      const SizedBox(height: 24),
      ],
    );
  }

  // ───────────────────────── BANNER Y FOTO ─────────────────────────

  Widget _banner() {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _bannerFondo,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          // FOTO DE PERFIL
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3F85A8),
                border: Border.all(
                  color: AppColors.azul,
                  width: 3,
                ),
                image: _fotoPerfil != null
                    ? DecorationImage(
                        image: MemoryImage(_fotoPerfil!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _fotoPerfil == null
                  ? const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 54,
                    )
                  : null,
            ),
          ),

          // BOTÓN EDITAR FOTO
          Positioned(
            top: 12,
            right: 12,
            child: Material(
              color: AppColors.fondoOscuro,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: _borde,
                  width: 2,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _seleccionarFoto,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── ESTADÍSTICAS ─────────────────────────

  Widget _tarjetaEstadistica(
    IconData icono,
    String valor,
    String titulo,
    Color color, {
    String? etiqueta,
    bool apagada = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 78,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _borde,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icono,
                color: color,
                size: 32,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valor,
                      style: TextStyle(
                        color: apagada ? _gris : Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),

                    Text(
                      titulo,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _gris,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (etiqueta != null)
          Positioned(
            top: -12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC800),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                etiqueta,
                style: const TextStyle(
                  color: Color(0xFF3C3C3C),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ───────────────────────── PANEL DERECHO ─────────────────────────

  Widget _panelAmigos() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _borde,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _tab('SIGUIENDO', 0),
              _tab('SEGUIDORES', 1),
            ],
          ),

          const Divider(
            color: _borde,
            thickness: 2,
            height: 2,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 20,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.groups_rounded,
                  size: 110,
                  color: Color(0xFF58CC02),
                ),

                const SizedBox(height: 16),

                Text(
                  _tabAmigos == 0
                      ? 'Aprender es más divertido y efectivo cuando lo haces con amigos.'
                      : 'Todavía no tienes seguidores. ¡Invita a tus amigos!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── PESTAÑAS ─────────────────────────

  Widget _tab(String texto, int index) {
    final activo = _tabAmigos == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _tabAmigos = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: activo
                ? AppColors.azul.withValues(alpha: 0.12)
                : null,
            border: Border(
              bottom: BorderSide(
                color: activo
                    ? AppColors.azul
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            texto,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: activo ? AppColors.azul : Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── AGREGAR AMIGOS ─────────────────────────

  Widget _agregarAmigos() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _borde,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Agregar amigos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 8),

          _filaAmigos(
            Icons.search_rounded,
            'Encuentra a tus amigos',
            const Color(0xFF1CB0F6),
          ),

          _filaAmigos(
            Icons.mail_rounded,
            'Invita a tus amigos',
            const Color(0xFF58CC02),
          ),
        ],
      ),
    );
  }

  Widget _filaAmigos(
    IconData icono,
    String texto,
    Color color,
  ) {
    return InkWell(
      onTap: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(texto)),
  );
},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Row(
          children: [
            Icon(
              icono,
              color: color,
              size: 34,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                texto,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}