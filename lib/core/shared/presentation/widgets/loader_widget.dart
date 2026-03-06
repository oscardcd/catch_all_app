import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.catching_pokemon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 24),
          Text(
            'Cargando...',
            style: GoogleFonts.outfit(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 140,
            child: LinearProgressIndicator(
              backgroundColor: isDark ? Colors.white10 : Colors.black12,
              color: const Color(0xFFFF4444),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
