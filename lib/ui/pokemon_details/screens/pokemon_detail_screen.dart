import 'package:catch_all_app/core/injector/injector.dart';
import 'package:catch_all_app/core/shared/presentation/theme/palette.dart';
import 'package:catch_all_app/ui/pokemon_details/bloc/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({required this.pokemonName, super.key});

  final String pokemonName;

  static const String route = '/pokemons/:name';
  static const String name = 'pokemons';

  static Widget builder(BuildContext _, GoRouterState state) {
    final name = state.pathParameters['name'] ?? 'unknown';
    return BlocProvider(
      create: (context) => PokemonBloc(Repositories.pokemonRepository)..add(PokemonEvent.fetchPokemonDetails(name)),
      child: PokemonDetailScreen(pokemonName: name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemonName.toUpperCase(),
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loadInProgress: () => const Center(child: CircularProgressIndicator()),
            pokemonLoaded: (pokemon) => _PokemonDetailView(pokemon: pokemon),
            failure: (error) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}

class _PokemonDetailView extends StatelessWidget {
  const _PokemonDetailView({required this.pokemon});

  final dynamic pokemon; // Using dynamic for now or import Pokemon entity

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 100),
          // Pokemon Image
          Center(
            child: Hero(
              tag: 'pokemon-${pokemon.id}',
              child: Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Types
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (pokemon.types as List).map<Widget>((t) {
              final typeName = t.type?.name ?? 'normal';
              final typeColor = Palette.pokemonTypeColors[typeName] ?? Palette.gray;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: typeColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  typeName.toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: typeColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Base Stats',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                ...(pokemon.stats as List).map((s) {
                  final statName = s.stat?.name ?? '';
                  final baseStat = s.baseStat ?? 0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              statName.toUpperCase(),
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            Text(
                              baseStat.toString(),
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: baseStat / 255,
                            backgroundColor: isDark ? Colors.white12 : Colors.black12,
                            color: _getStatColor(statName),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Color _getStatColor(String name) {
    switch (name) {
      case 'hp':
        return Colors.green;
      case 'attack':
        return Colors.red;
      case 'defense':
        return Colors.blue;
      case 'special-attack':
        return Colors.purple;
      case 'special-defense':
        return Colors.indigo;
      case 'speed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
