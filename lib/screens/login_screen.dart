import 'package:flutter/material.dart';
import '../colors.dart';
import 'home_screen.dart';

const String usuarioCorrecto = 'admin';
const String passwordCorrecta = '1234';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _ocultar = true;

  @override
  void dispose() {
    _usuarioCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _mensaje(String texto, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), backgroundColor: color),
    );
  }

  void _login() {
    final usuario = _usuarioCtrl.text.trim();
    final password = _passCtrl.text;

    if (usuario.isEmpty || password.isEmpty) {
      _mensaje('Completa todos los campos', AppColors.rojo);
      return;
    }
    if (usuario == usuarioCorrecto && password == passwordCorrecta) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      _mensaje('Usuario o contraseña incorrectos', AppColors.rojo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listo = _usuarioCtrl.text.isNotEmpty && _passCtrl.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Ingresa tus datos',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF202F36),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: const Color(0xFF37464F), width: 2),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _usuarioCtrl,
                                  onChanged: (_) => setState(() {}),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Usuario o correo',
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(18),
                                  ),
                                ),
                                const Divider(
                                    height: 2, color: Color(0xFF37464F)),
                                TextField(
                                  controller: _passCtrl,
                                  obscureText: _ocultar,
                                  onChanged: (_) => setState(() {}),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Contraseña',
                                    hintStyle:
                                        const TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(18),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _ocultar
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.azul,
                                      ),
                                      onPressed: () =>
                                          setState(() => _ocultar = !_ocultar),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: listo
                                    ? AppColors.azul
                                    : const Color(0xFF37464F),
                                foregroundColor:
                                    listo ? Colors.white : Colors.white38,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'INGRESAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () => _mensaje(
                                'Función no disponible en la simulación',
                                AppColors.morado),
                            child: const Text(
                              'RESTABLECER CONTRASEÑA',
                              style: TextStyle(
                                  color: AppColors.azul,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _botonSocial(Icons.g_mobiledata, 'INGRESA CON GOOGLE'),
                  const SizedBox(height: 12),
                  _botonSocial(Icons.facebook, 'INGRESA CON FACEBOOK'),
                  const SizedBox(height: 16),
                  const Text(
                    'Al registrarte en Duolingo, aceptas nuestros Términos y Política de privacidad.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonSocial(IconData icono, String texto) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () => _mensaje(
            'Función no disponible en la simulación', AppColors.morado),
        icon: Icon(icono, color: Colors.white, size: 28),
        label: Text(
          texto,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF37464F), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
