# Duolingo_segundo_parcial

Simulación de interfaces de Duolingo con Flutter y Dart. Programación Multiplataforma, II Parcial.

## Aplicación asignada
Duolingo

## Plataforma
Web

## Integrantes
- Pamela Nicolle Jiménez Cruz
- Fernando José Blandón González

## Descripción
Duolingo es una aplicación para aprender idiomas con lecciones cortas, misiones diarias, racha de días y perfil de usuario. Este proyecto simula sus pantallas principales con datos estáticos.

## Pantallas
1. Login: lib/screens/login_screen.dart
2. Home: lib/screens/home_screen.dart
3. Misiones (Desafíos): lib/screens/pantalla_adicional_1.dart
4. Perfil: lib/screens/pantalla_adicional_2.dart

Pantallas extra: Ligas (lib/screens/ligas_screen.dart) y Tienda (lib/screens/tienda_screen.dart).

## Interacciones
- Login: mostrar u ocultar la contraseña, validación de campos vacíos y mensaje de error con credenciales incorrectas.
- Home: el botón GUÍA muestra y oculta la guía de la unidad, el nodo EMPEZAR abre una ventana para iniciar la lección y al completarla se actualiza el progreso y la EXP.
- Misiones (Desafíos): botón que suma XP a la barra de progreso del desafío con setState.
- Perfil: cambiar de pestaña en la sección de amigos, elegir una foto de perfil desde las imágenes del dispositivo y cerrar sesión para volver al Login.

## Usuario de prueba
- Correo: admin@duolingo.com
- Contraseña: 1234

## Cómo ejecutar
    flutter pub get
    flutter run -d chrome
