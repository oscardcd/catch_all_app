import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:catch_all_app/ui/home/screens/screens.dart';
import 'package:catch_all_app/ui/pokemon_details/bloc/pokemon_cubit/pokemon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catch_all_app/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({required this.pokemonName, this.pokemonId, super.key});

  final String pokemonName;
  final int? pokemonId;

  static const String route = '/pokemons/:name';
  static const String name = 'pokemons';

  static Widget builder(BuildContext _, GoRouterState state) {
    final name = state.pathParameters['name'] ?? 'unknown';
    final id = state.extra is int ? state.extra as int : null;
    return BlocProvider(
      create: (context) => PokemonCubit(Repositories.pokemonRepository)..fetchPokemonDetails(name),
      child: BlocListener<PokemonCubit, PokemonState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            pokemonLoaded: (pokemon) {
              if (pokemon.id == null) {
                context.goNamed(HomeScreen.name);
              }
            },
            failure: (error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
              context.goNamed(HomeScreen.name);
            },
          );
        },
        child: PokemonDetailScreen(pokemonName: name, pokemonId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<PokemonCubit, PokemonState, Pokemon?>(
          selector: (state) => state.pokemon,
          builder: (context, pokemon) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pokemonName.toUpperCase(), style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
                Text(
                  '#${(pokemon?.id ?? pokemonId)?.toString().padLeft(3, '0') ?? ''}',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          return state.maybeWhen(
            loadInProgress: () {
              if (pokemonId != null) {
                // If we have an ID, show a skeleton that includes the Hero
                return _PokemonDetailView(
                  pokemon: Pokemon(id: pokemonId, name: pokemonName),
                  isLoading: true,
                );
              }
              return LoaderWidget();
            },
            pokemonLoaded: (pokemon) => _PokemonDetailView(pokemon: pokemon),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _PokemonDetailView extends StatelessWidget {
  const _PokemonDetailView({required this.pokemon, this.isLoading = false});

  final Pokemon pokemon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryType = pokemon.types.firstOrNull?.type?.name ?? 'normal';
    final typeColor = Palette.pokemonTypeColors[primaryType] ?? Palette.gray;

    return Stack(
      children: [
        // Background Gradient
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [typeColor, typeColor.withValues(alpha: 0.8)],
            ),
          ),
        ),

        // Content
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              // Pokemon Image
              Center(
                child: Hero(
                  tag: 'pokemon-${pokemon.id}',
                  child: CachedNetworkImage(
                    imageUrl:
                        pokemon.sprites?.other?.officialArtwork?.frontDefault ??
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
                    height: 280,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
                      fit: BoxFit.contain,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 100),
                  ),
                ),
              ),

              gap16,

              // White Card Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1D23) : Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, -10)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and ID
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              (pokemon.name ?? 'Unknown').toUpperCase(),
                              style: GoogleFonts.outfit(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Types Chips
                      if (isLoading)
                        const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: LoaderWidget())
                      else ...[
                        Wrap(
                          spacing: 12,
                          children: pokemon.types.map((t) {
                            final name = t.type?.name ?? 'normal';
                            final color = Palette.pokemonTypeColors[name] ?? Palette.gray;
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                name.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],

                      if (!isLoading) ...[
                        const SizedBox(height: 40),

                        // Height, Weight, Abilities
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoItem(
                              context,
                              '${(pokemon.height ?? 0) / 10} m',
                              t.pokemonDetails.height,
                              Icons.height,
                            ),
                            _buildInfoItem(
                              context,
                              '${(pokemon.weight ?? 0) / 10} kg',
                              t.pokemonDetails.weight,
                              Icons.monitor_weight_outlined,
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Abilities
                        Text(
                          t.pokemonDetails.abilities,
                          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              pokemon.abilities?.map((a) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.white12 : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                                    ),
                                  ),
                                  child: Text(
                                    (a.ability?.name ?? '').toUpperCase(),
                                    style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                );
                              }).toList() ??
                              [],
                        ),

                        const SizedBox(height: 40),

                        // Stats
                        Text(
                          t.pokemonDetails.baseStats,
                          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 24),
                        ...?pokemon.stats?.map((s) {
                          final statName = s.stat?.name ?? '';
                          final baseStat = s.baseStat ?? 0;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
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
                                        fontWeight: FontWeight.w700,
                                        color: isDark ? Colors.white60 : Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      baseStat.toString(),
                                      style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: typeColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Stack(
                                  children: [
                                    Container(
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: isDark ? Colors.white10 : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: min(baseStat / 150, 1.0),
                                      child: Container(
                                        height: 10,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [typeColor.withValues(alpha: 0.6), typeColor],
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: typeColor.withValues(alpha: 0.3),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String value, String label, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: isDark ? Colors.white70 : Colors.black54),
            const SizedBox(width: 8),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white38 : Colors.black38,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
