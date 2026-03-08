import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/ui/home/bloc/home_bloc.dart';
import 'package:catch_all_app/ui/home/widgets/pokemon_grid_section.dart';
import 'package:catch_all_app/ui/home/widgets/favorites_carousel_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:catch_all_app/ui/home/cubit/catch_pokemon_cubit/catch_pokemon_cubit.dart';
import 'package:catch_all_app/ui/home/cubit/catch_pokemon_cubit/catch_pokemon_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = '/';
  static const String name = 'home';

  static Widget builder(BuildContext _, GoRouterState _) {
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(Repositories.pokemonRepository)..add(const HomeEvent.loadInitialPokemons()),
        ),
        BlocProvider(create: (_) => CatchPokemonCubit(Repositories.pokemonRepository)),
      ],
      child: BlocListener<CatchPokemonCubit, CatchPokemonState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (pokemonId) {
              context.read<HomeBloc>().add(HomeEvent.catchPokemon(pokemonId));
              context.read<CatchPokemonCubit>().reset();
            },
            failure: (error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
            },
            orElse: () {},
          );
        },
        child: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const LoaderWidget(),
                    loading: () => const LoaderWidget(),
                    loaded: (pokemons, favorites, caught, hasMore, offset) => _HomeContent(
                      pokemons: pokemons,
                      favoriteIds: favorites,
                      hasMore: hasMore,
                      currentOffset: offset,
                    ),
                    loadingMore: (pokemons, favorites, caught, offset) => _HomeContent(
                      pokemons: pokemons,
                      favoriteIds: favorites,
                      hasMore: true,
                      currentOffset: offset,
                      isLoadingMore: true,
                    ),
                    failure: (msg) => _ErrorView(message: msg),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          FutureBuilder(
            future: Repositories.auth.getCurrentUser(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              final name = user?.displayName ?? 'Entrenador';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Hola, $name!',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    '¿A quién atraparemos hoy?',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            },
          ),
          const Spacer(),
          GestureDetector(onTap: () => _showSettingsMenu(context), child: const PokeBallIcon()),
        ],
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.canvasColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, currentMode) {
            final isDark = theme.brightness == Brightness.dark;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ajustes de Tema',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildThemeOption(
                      context,
                      'Modo Claro',
                      Icons.light_mode_rounded,
                      ThemeMode.light,
                      currentMode == ThemeMode.light,
                    ),
                    _buildThemeOption(
                      context,
                      'Modo Oscuro',
                      Icons.dark_mode_rounded,
                      ThemeMode.dark,
                      currentMode == ThemeMode.dark,
                    ),
                    _buildThemeOption(
                      context,
                      'Sistema',
                      Icons.settings_suggest_rounded,
                      ThemeMode.system,
                      currentMode == ThemeMode.system,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider()),
                    ListTile(
                      leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                      title: Text(
                        'Cerrar Sesión',
                        style: GoogleFonts.outfit(color: Colors.redAccent, fontWeight: FontWeight.w600),
                      ),
                      onTap: () async {
                        await Repositories.auth.signOut();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context, String label, IconData icon, ThemeMode mode, bool isSelected) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = theme.colorScheme.primary;

    return ListTile(
      leading: Icon(icon, color: isSelected ? activeColor : (isDark ? Colors.white54 : Colors.black54)),
      title: Text(
        label,
        style: GoogleFonts.outfit(
          color: isSelected ? (isDark ? Colors.white : Colors.black) : (isDark ? Colors.white54 : Colors.black54),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected ? Icon(Icons.check_circle_rounded, color: activeColor) : null,
      onTap: () {
        context.read<ThemeCubit>().updateTheme(mode);
        Navigator.pop(context);
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.pokemons,
    required this.favoriteIds,
    required this.hasMore,
    required this.currentOffset,
    this.isLoadingMore = false,
  });

  final List<PokemonEntry> pokemons;
  final List<int> favoriteIds;
  final bool hasMore;
  final int currentOffset;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    final favorites = pokemons.where((p) => favoriteIds.contains(p.id)).toList();

    return Column(
      children: [
        const SizedBox(height: 16),
        // Top 70% - Pokemon Grid
        Expanded(
          flex: 70,
          child: PokemonGridSection(
            pokemons: pokemons,
            favoriteIds: favoriteIds,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            onLoadMore: () {
              context.read<HomeBloc>().add(const HomeEvent.loadMorePokemons());
            },
            onFavoriteToggle: (id) {
              context.read<HomeBloc>().add(HomeEvent.toggleFavorite(id));
            },
          ),
        ),
        // Divider
        _buildSectionDivider(context, favorites.length),
        // Bottom 30% - Favorites Carousel
        Expanded(
          flex: 30,
          child: FavoritesCarouselSection(
            favorites: favorites,
            onFavoriteToggle: (id) {
              context.read<HomeBloc>().add(HomeEvent.toggleFavorite(id));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionDivider(BuildContext context, int favCount) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            'Favoritos',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          if (favCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.5)),
              ),
              child: Text(
                '$favCount',
                style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFFFFD700)),
              ),
            ),
          const Spacer(),
          Container(
            height: 1,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isDark ? const Color(0xFFFF4444) : Palette.primaryLight.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFFF4444), size: 56),
            const SizedBox(height: 16),
            Text(
              'Algo salió mal',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: isDark ? Colors.white38 : Colors.black38, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeBloc>().add(const HomeEvent.loadInitialPokemons());
              },
              icon: const Icon(Icons.refresh),
              label: Text('Reintentar', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4444),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
