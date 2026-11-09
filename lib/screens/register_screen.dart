import 'package:flutter/material.dart';
import '../colors.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool ocultarPassword = true;

  void mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto)),
    );
  }

  void actualizar(String texto) {
    setState(() {});
  }

  void cambiarVisibilidad() {
    setState(() {
      ocultarPassword = !ocultarPassword;
    });
  }

  void crearCuenta() {
    if (correoController.text.isEmpty || passwordController.text.isEmpty) {
      mostrarMensaje('Completa el correo y la contraseña');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool camposLlenos = correoController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.fondoOscuro,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Fila superior con flecha de regreso y botón INGRESAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white70),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF37464F), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'INGRESAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Contenido central de "Crea tu perfil"
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Crea tu perfil',
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
                                  controller: nombreController,
                                  onChanged: actualizar,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Nombre (opcional)',
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
                                  controller: correoController,
                                  onChanged: actualizar,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Correo',
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
                                    hintText: 'Contraseña',
                                    hintStyle:
                                        const TextStyle(color: Colors.white38),
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
                              onPressed: crearCuenta,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: camposLlenos
                                    ? AppColors.azul
                                    : const Color(0xFF37464F),
                                foregroundColor:
                                    camposLlenos ? Colors.white : Colors.white38,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'CREAR CUENTA',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Términos y políticas con enlaces en azul
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(color: Colors.white38, fontSize: 12),
                              children: [
                                TextSpan(text: 'Al registrarte en Duolingo, aceptas nuestros '),
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
                              style: TextStyle(color: Colors.white30, fontSize: 10),
                              children: [
                                TextSpan(text: 'Esta página está protegida por reCAPTCHA Enterprise. Aplican tanto la '),
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
