import 'package:catch_all_app/ui/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A snapping horizontal carousel that highlights the center item.
class FavoritesCarouselSection extends StatefulWidget {
  const FavoritesCarouselSection({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  final List<PokemonEntry> favorites;
  final ValueChanged<int> onFavoriteToggle;

  @override
  State<FavoritesCarouselSection> createState() => _FavoritesCarouselSectionState();
}

class _FavoritesCarouselSectionState extends State<FavoritesCarouselSection> {
  late PageController _pageController;
  int _currentPage = 0;

  static const double _viewportFraction = 0.45;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _viewportFraction);
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void didUpdateWidget(FavoritesCarouselSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.favorites.length < oldWidget.favorites.length &&
        _currentPage >= widget.favorites.length &&
        widget.favorites.isNotEmpty) {
      final newPage = (widget.favorites.length - 1).clamp(0, 999);
      _pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favorites.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.favorites.length,
            itemBuilder: (context, index) {
              final pokemon = widget.favorites[index];
              final isCentered = index == _currentPage;

              return AnimatedScale(
                scale: isCentered ? 1.0 : 0.82,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: isCentered ? 1.0 : 0.55,
                  duration: const Duration(milliseconds: 250),
                  child: _FavoriteCarouselCard(
                    pokemon: pokemon,
                    isActive: isCentered,
                    onRemove: () => widget.onFavoriteToggle(pokemon.id),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.favorites.length > 1) _buildIndicator(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.favorites.length, (index) {
          final isActive = index == _currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: isActive ? 20 : 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_outline_rounded,
            color: Colors.white.withOpacity(0.15),
            size: 36,
          ),
          const SizedBox(height: 8),
          Text(
            'Mantén presionado un Pokémon\npara añadirlo a favoritos',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: Colors.white24,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCarouselCard extends StatelessWidget {
  const _FavoriteCarouselCard({
    required this.pokemon,
    required this.isActive,
    required this.onRemove,
  });

  final PokemonEntry pokemon;
  final bool isActive;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: isActive
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2C1F3E),
                  Color(0xFF1A1030),
                ],
              )
            : const LinearGradient(
                colors: [Color(0xFF161B27), Color(0xFF0F1319)],
              ),
        border: Border.all(
          color: isActive ? const Color(0xFFFFD700).withOpacity(0.5) : Colors.white.withOpacity(0.06),
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFFFFD700).withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Stack(
        children: [
          // Background pokeball watermark
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.06,
              child: Icon(
                Icons.catching_pokemon,
                size: 80,
                color: isActive ? const Color(0xFFFFD700) : Colors.white,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID + star badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFFFD700).withOpacity(0.15) : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isActive ? const Color(0xFFFFD700) : Colors.white38,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFD700),
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                // Pokemon image
                Expanded(
                  child: Center(
                    child: Image.network(
                      pokemon.spriteUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.catching_pokemon,
                        color: Colors.white24,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                // Name
                Text(
                  _capitalize(pokemon.name),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
