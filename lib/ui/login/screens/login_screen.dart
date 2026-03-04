import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:catch_all_app/core/core.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen._();

  static const String route = '/login';
  static const String name = 'login';

  static Widget builder(BuildContext _, GoRouterState __) {
    return const LoginScreen._();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.lightBlue, // Modern flat background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: edgeInsetsH24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              gap40,
              // App Logo placeholder
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Palette.secondaryLight.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Palette.secondaryLight,
                  size: 40,
                ),
              ),
              gap28,
              Text(
                'Bienvenido de nuevo',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Palette.primaryLight,
                ),
              ),
              gap8,
              Text(
                'Ingresa tus credenciales para continuar',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  color: Palette.gray,
                ),
              ),
              gap40,

              // Email / User Field
              Text(
                'Usuario',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Palette.primaryLight,
                ),
              ),
              gap8,
              TextField(
                style: GoogleFonts.outfit(),
                decoration: InputDecoration(
                  hintText: 'nombre@ejemplo.com',
                  prefixIcon: const Icon(Icons.person_outline, size: 20),
                  filled: true,
                  fillColor: Palette.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  border: const OutlineInputBorder(
                    borderRadius: borderRadius12,
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius12,
                    borderSide: BorderSide(color: Palette.gray.withAlpha(50), width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: borderRadius12,
                    borderSide: BorderSide(color: Palette.secondaryLight, width: 2),
                  ),
                ),
              ),
              gap24,

              // Password Field
              Text(
                'Contraseña',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Palette.primaryLight,
                ),
              ),
              gap8,
              TextField(
                // controller: _passwordController,
                // obscureText: !_isPasswordVisible,
                style: GoogleFonts.outfit(),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  filled: true,
                  fillColor: Palette.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  border: const OutlineInputBorder(
                    borderRadius: borderRadius12,
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius12,
                    borderSide: BorderSide(color: Palette.gray.withAlpha(50), width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: borderRadius12,
                    borderSide: BorderSide(color: Palette.secondaryLight, width: 2),
                  ),
                ),
              ),

              gap12,
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: GoogleFonts.outfit(
                      color: Palette.secondaryLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              gap28,

              // Login Button
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.secondaryLight,
                  foregroundColor: Palette.white,
                  padding: edgeInsetsV16,
                  shape: const RoundedRectangleBorder(
                    borderRadius: borderRadius12,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Iniciar Sesión',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              gap28,

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Palette.gray.withAlpha(50))),
                  Padding(
                    padding: edgeInsetsH16,
                    child: Text(
                      'O continúa con',
                      style: GoogleFonts.outfit(
                        color: Palette.gray,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Palette.gray.withAlpha(50))),
                ],
              ),

              gap28,

              // Google Button
              OutlinedButton.icon(
                onPressed: () {
                  // Handle Google sign in
                },
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color(0xFFEA4335), // Google's official red color, keeping it intact
                  size: 18,
                ),
                label: Text(
                  'Google',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Palette.primaryLight,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Palette.gray.withAlpha(50)),
                  shape: const RoundedRectangleBorder(
                    borderRadius: borderRadius12,
                  ),
                  backgroundColor: Palette.white,
                ),
              ),

              gap40,

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes una cuenta? ',
                    style: GoogleFonts.outfit(
                      color: Palette.gray,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Regístrate',
                      style: GoogleFonts.outfit(
                        color: Palette.secondaryLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              gap24,
            ],
          ),
        ),
      ),
    );
  }
}
