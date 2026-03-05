import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/ui/home/bloc/home_bloc.dart';
import 'package:catch_all_app/ui/home/widgets/pokemon_grid_section.dart';
import 'package:catch_all_app/ui/home/widgets/favorites_carousel_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = '/';
  static const String name = 'home';

  static Widget builder(BuildContext _, GoRouterState __) {
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(Repositories.pokemonRepository)..add(const HomeEvent.loadInitialPokemons()),
      child: const _HomeView(),
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
                    initial: () => const _LoadingView(),
                    loading: () => const _LoadingView(),
                    loaded: (pokemons, favorites, hasMore, offset) => _HomeContent(
                      pokemons: pokemons,
                      favoriteIds: favorites,
                      hasMore: hasMore,
                      currentOffset: offset,
                    ),
                    loadingMore: (pokemons, favorites, offset) => _HomeContent(
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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Catch \'em all!',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: theme.textTheme.headlineLarge?.color,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Descubrelos!',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: theme.textTheme.headlineLarge?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _showSettingsMenu(context),
            child: const PokeBallIcon(),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => context.go('/login'),
            icon: const Icon(Icons.logout_rounded, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, currentMode) {
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
                        color: Colors.white,
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
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode mode,
    bool isSelected,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFFFF4444) : Colors.white54,
      ),
      title: Text(
        label,
        style: GoogleFonts.outfit(
          color: isSelected ? Colors.white : Colors.white54,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: Color(0xFFFF4444)) : null,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            'Favoritos',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          if (favCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFFFD700).withOpacity(0.5),
                ),
              ),
              child: Text(
                '$favCount',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFD700),
                ),
              ),
            ),
          const Spacer(),
          Container(
            height: 1,
            width: 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF4444), Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeBloc>().add(const HomeEvent.loadInitialPokemons());
              },
              icon: const Icon(Icons.refresh),
              label: Text(
                'Reintentar',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              ),
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
