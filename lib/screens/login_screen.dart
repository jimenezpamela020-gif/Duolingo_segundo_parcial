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
  final TextEditingController usuarioController = TextEditingController();
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

  void iniciarSesion() {
    String usuario = usuarioController.text;
    String password = passwordController.text;

    if (usuario.isEmpty || password.isEmpty) {
      mostrarMensaje('Completa todos los campos');
    } else if (usuario == usuarioCorrecto && password == passwordCorrecta) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      mostrarMensaje('Usuario o contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool camposLlenos = usuarioController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.fondoOscuro,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Fila superior con la "X" a la izquierda y el botón "INGRESAR" a la derecha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () {
                      mostrarMensaje('Acción de cerrar');
                    },
                  ),
                  OutlinedButton(
                    onPressed: iniciarSesion,
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
              // Contenido central adaptado al diseño web
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿Cuántos años tienes?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                  controller: usuarioController,
                                  onChanged: actualizar,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Usuario o correo',
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
                          const SizedBox(height: 12),
                          // Texto con Política de Privacidad en azul
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(color: Colors.white38, fontSize: 13),
                              children: [
                                TextSpan(text: 'Agregar tu edad te garantiza una experiencia adaptada en Duolingo. Para más información, por favor consulta nuestra '),
                                TextSpan(
                                  text: 'Política de Privacidad.',
                                  style: TextStyle(color: Color(0xFF1CB0F6), fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: iniciarSesion,
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
                                'CONTINUAR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: Color(0xFF37464F), thickness: 1),
                          const SizedBox(height: 16),
                          // Botones de redes sociales inferiores con logo real de Google
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    mostrarMensaje('Función no disponible');
                                  },
                                  icon: Image.asset(
                                    'assets/images/google.png',
                                    width: 22,
                                    height: 22,
                                  ),
                                  label: const Text('GOOGLE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFF37464F), width: 2),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    mostrarMensaje('Función no disponible');
                                  },
                                  icon: const Icon(Icons.apple, size: 24, color: Colors.white),
                                  label: const Text('APPLE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFF37464F), width: 2),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Al registrarte en Duolingo, aceptas nuestros Términos y Política de privacidad.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white38, fontSize: 11),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Esta página está protegida por reCAPTCHA Enterprise. Aplican tanto la política de privacidad como los términos del servicio de Google.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white30, fontSize: 10),
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
