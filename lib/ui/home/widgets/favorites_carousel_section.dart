import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/ui/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A snapping horizontal carousel that highlights the center item.
class FavoritesCarouselSection extends StatefulWidget {
  const FavoritesCarouselSection({super.key, required this.favorites, required this.onFavoriteToggle});

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
      _pageController.animateToPage(newPage, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
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
              color: isActive
                  ? const Color(0xFFFFD700)
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.15), size: 48),
          const SizedBox(height: 12),
          Text(
            'Mantén presionado un Pokémon\npara añadirlo a favoritos',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCarouselCard extends StatelessWidget {
  const _FavoriteCarouselCard({required this.pokemon, required this.isActive, required this.onRemove});

  final PokemonEntry pokemon;
  final bool isActive;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onLongPress: () => _showRemoveConfirmation(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius16,
          border: Border.all(
            color: isActive
                ? const Color(0xFFFFD700).withValues(alpha: 0.8)
                : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.06)),
            width: isActive ? 2.0 : 1.0,
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(color: const Color(0xFFFFD700).withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 1)
            else
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Stack(
          children: [
            // Background pokeball watermark
            Positioned(
              right: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.06,
                child: Icon(Icons.catching_pokemon, size: 80, color: isActive ? const Color(0xFFFFD700) : Colors.white),
              ),
            ),
            // Content
            Padding(
              padding: edgeInsetsH16.add(edgeInsetsV8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID + star badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFFFD700).withValues(alpha: 0.15)
                              : context.colorScheme.primary.withValues(alpha: 0.05),
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
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                          child: const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 16),
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
                        color: pokemon.isCaught ? null : Colors.black.withValues(alpha: 0.85),
                        colorBlendMode: pokemon.isCaught ? null : BlendMode.srcIn,
                        errorBuilder: (_, _, _) => const Icon(Icons.catching_pokemon, color: Colors.white24, size: 50),
                      ),
                    ),
                  ),
                  // Name
                  Text(
                    pokemon.isCaught ? _capitalize(pokemon.name) : '???',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isActive
                          ? (isDark ? Colors.white : Palette.primaryLight)
                          : (isDark ? Colors.white54 : Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRemoveConfirmation(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('¿Quitar de favoritos?', style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
        content: Text(
          '¿Estás seguro de que quieres eliminar a ${_capitalize(pokemon.name)} de tus favoritos?',
          style: GoogleFonts.outfit(color: isDark ? Colors.white70 : Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.outfit(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onRemove();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Sí, quitar', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
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
