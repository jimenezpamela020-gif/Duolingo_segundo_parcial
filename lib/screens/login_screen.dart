import 'package:flutter/material.dart';

import '../colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool ocultarPassword = true;

  // 🔹 Credenciales estáticas 
  static const String correoCorrecto = 'admin@duolingo.com';
  static const String passwordCorrecta = '1234';

  void mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  void actualizar(String texto) {
    setState(() {});
  }

  void cambiarVisibilidad() {
    setState(() {
      ocultarPassword = !ocultarPassword;
    });
  }

  void iniciarSesion() {
    if (correoController.text.isEmpty || passwordController.text.isEmpty) {
      mostrarMensaje('Completa el correo y la contraseña');
    } else if (correoController.text != correoCorrecto ||
        passwordController.text != passwordCorrecta) {
      // Validación contra las credenciales estáticas
      mostrarMensaje('Correo o contraseña incorrectos');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool camposLlenos =
        correoController.text.isNotEmpty && passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.fondoOscuro,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Contenido central de "Inicia sesión"
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Inicia sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF202F36),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF37464F),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: correoController,
                                  onChanged: actualizar,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Correo ',
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(18),
                                  ),
                                ),
                                const Divider(
                                  height: 2,
                                  color: Color(0xFF37464F),
                                ),
                                TextField(
                                  controller: passwordController,
                                  obscureText: ocultarPassword,
                                  onChanged: actualizar,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Contraseña ',
                                    hintStyle: const TextStyle(
                                      color: Colors.white38,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(18),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        ocultarPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.azul,
                                      ),
                                      onPressed: cambiarVisibilidad,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: iniciarSesion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: camposLlenos
                                    ? AppColors.azul
                                    : const Color(0xFF37464F),
                                foregroundColor: camposLlenos
                                    ? Colors.white
                                    : Colors.white38,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'ENTRAR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Términos y políticas con enlaces en azul
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Al iniciar sesión en Duolingo, aceptas nuestros ',
                                ),
                                TextSpan(
                                  text: 'Términos',
                                  style: TextStyle(color: Color(0xFF1CB0F6)),
                                ),
                                TextSpan(text: ' y '),
                                TextSpan(
                                  text: 'Política de privacidad.',
                                  style: TextStyle(color: Color(0xFF1CB0F6)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.white30,
                                fontSize: 10,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Esta página está protegida por reCAPTCHA Enterprise. Aplican tanto la ',
                                ),
                                TextSpan(
                                  text: 'política de privacidad',
                                  style: TextStyle(color: Color(0xFF1CB0F6)),
                                ),
                                TextSpan(text: ' como los '),
                                TextSpan(
                                  text: 'términos del servicio',
                                  style: TextStyle(color: Color(0xFF1CB0F6)),
                                ),
                                TextSpan(text: ' de Google.'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
