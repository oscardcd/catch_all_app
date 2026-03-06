import 'dart:math';
import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/ui/home/bloc/home_bloc.dart';
import 'package:catch_all_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// Pokemon type color mapping is now centrally managed in Palette.pokemonTypeColors

/// A horizontal scrolling grid with 2 rows, up to 6 pokémon per "column-page".
class PokemonGridSection extends StatefulWidget {
  const PokemonGridSection({
    super.key,
    required this.pokemons,
    required this.favoriteIds,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onFavoriteToggle,
  });

  final List<PokemonEntry> pokemons;
  final List<int> favoriteIds;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final ValueChanged<int> onFavoriteToggle;

  @override
  State<PokemonGridSection> createState() => _PokemonGridSectionState();
}

class _PokemonGridSectionState extends State<PokemonGridSection> {
  final _scrollController = ScrollController();

  static const int _rows = 3;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        widget.hasMore &&
        !widget.isLoadingMore) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build columns of _rows items each
    final columns = <List<PokemonEntry>>[];
    for (var i = 0; i < widget.pokemons.length; i += _rows) {
      final end = min(i + _rows, widget.pokemons.length);
      columns.add(widget.pokemons.sublist(i, end));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: edgeInsetsH16.add(edgeInsetsV12),
          child: Row(
            children: [
              Text(
                'Pokémons',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              space8,
              Container(
                padding: edgeInsetsH8V2,
                decoration: BoxDecoration(
                  color: Palette.pokemonRed.withValues(alpha: 0.15),
                  borderRadius: borderRadius10,
                  border: Border.all(color: Palette.pokemonRed.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${widget.pokemons.length}',
                  style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFFFF4444)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                _onScroll();
              }
              return false;
            },
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: edgeInsetsH16,
              itemCount: columns.length + (widget.isLoadingMore ? 1 : 0),
              itemBuilder: (context, colIndex) {
                if (colIndex == columns.length) {
                  return _buildLoadingColumn();
                }
                final col = columns[colIndex];
                return Column(
                  children: List.generate(_rows, (rowIndex) {
                    if (rowIndex < col.length) {
                      final pokemon = col[rowIndex];
                      return _PokemonGridCard(
                        pokemon: pokemon,
                        isFavorite: widget.favoriteIds.contains(pokemon.id),
                        onFavoriteToggle: () => widget.onFavoriteToggle(pokemon.id),
                      );
                    }
                    return const SizedBox(width: 82, height: 82);
                  }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingColumn() {
    return Column(
      children: List.generate(
        _rows,
        (_) => const Padding(padding: edgeInsets4, child: LoadingPlaceholder(width: 82, height: 82)),
      ),
    );
  }
}

class _PokemonGridCard extends StatefulWidget {
  const _PokemonGridCard({required this.pokemon, required this.isFavorite, required this.onFavoriteToggle});

  final PokemonEntry pokemon;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  @override
  State<_PokemonGridCard> createState() => _PokemonGridCardState();
}

class _PokemonGridCardState extends State<_PokemonGridCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnim,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnim.value, child: child);
      },
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            PokemonDetailScreen.name,
            pathParameters: {'name': widget.pokemon.name},
            extra: widget.pokemon.id,
          );
        },
        onLongPress: widget.onFavoriteToggle,
        child: Container(
          width: 82,
          height: 82,
          margin: edgeInsets4,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withValues(alpha: 0.4),
            borderRadius: borderRadius16,
            border: Border.all(
              color: widget.isFavorite
                  ? const Color(0xFFFFD700).withValues(alpha: 0.8)
                  : (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.08)),
              width: widget.isFavorite ? 2.0 : 1.0,
            ),
            boxShadow: [
              if (widget.isFavorite)
                BoxShadow(color: const Color(0xFFFFD700).withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 1)
              else
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: ClipRRect(
            borderRadius: borderRadius16,
            child: Stack(
              children: [
                // Subtle background pattern or tint
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white.withValues(alpha: 0.02), Colors.black.withValues(alpha: 0.01)],
                      ),
                    ),
                  ),
                ),

                // Pokemon image
                Positioned.fill(
                  child: Image.network(
                    'https://img.pokemondb.net/sprites/home/normal/${widget.pokemon.name.toLowerCase()}.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const PokeBallIcon(size: 24),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return PokeBallIcon();
                    },
                  ),
                ),
                // Pokemon ID
                Positioned(
                  top: 6,
                  left: 8,
                  child: Text(
                    '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                    style: GoogleFonts.outfit(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                // Favorite star
                if (widget.isFavorite)
                  Positioned(
                    top: 4,
                    right: 6,
                    child: GestureDetector(
                      onTap: widget.onFavoriteToggle,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4)],
                        ),
                        child: const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 14),
                      ),
                    ),
                  ),
                // Name label at bottom (Glassmorphism look)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary.withValues(alpha: 0.7),
                      borderRadius: borderRadius16,
                    ),
                    child: Text(
                      _capitalize(widget.pokemon.name),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.surface,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
