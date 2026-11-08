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
      appBar: AppBar(
        title: const Text(
          'Ingresa tus datos',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        centerTitle: true,
        backgroundColor: AppColors.fondoOscuro,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                                'INGRESAR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () {
                              mostrarMensaje('Función no disponible');
                            },
                            child: const Text(
                              'RESTABLECER CONTRASEÑA',
                              style: TextStyle(
                                color: AppColors.azul,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        mostrarMensaje('Función no disponible');
                      },
                      icon: Image.asset('assets/images/google.png', width: 24, height: 24),
                      label: const Text(
                        'INGRESA CON GOOGLE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF37464F),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        mostrarMensaje('Función no disponible');
                      },
                      icon: const Icon(
                        Icons.facebook,
                        size: 28,
                        color: Color(0xFF1877F2),
                      ),
                      label: const Text(
                        'INGRESA CON FACEBOOK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF37464F),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Al registrarte en Duolingo, aceptas nuestros Términos y Política de privacidad.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

