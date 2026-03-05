import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4444), Color(0xFF880000)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4444).withOpacity(0.4),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(Icons.catching_pokemon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            'Cargando Pokémons...',
            style: GoogleFonts.outfit(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          const SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFF1E2533),
              color: Color(0xFFFF4444),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ],
      ),
    );
  }
}
