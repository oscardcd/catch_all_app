import 'dart:math';
import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/ui/home/bloc/home_bloc.dart';
import 'package:catch_all_app/ui/home/cubit/catch_pokemon_cubit/catch_pokemon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late final ScrollController _scrollController;

  static const int _rows = 3;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
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
                  color: context.colorScheme.onSurface,
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
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: edgeInsetsH16,
            itemCount: (widget.pokemons.length / _rows).ceil() + (widget.hasMore ? 1 : 0),
            itemBuilder: (context, colIndex) {
              if (colIndex >= (widget.pokemons.length / _rows).ceil()) {
                return _buildLoadingColumn();
              }

              final startIndex = colIndex * _rows;
              final endIndex = min(startIndex + _rows, widget.pokemons.length);
              final col = widget.pokemons.sublist(startIndex, endIndex);

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: () {
          if (!widget.pokemon.isCaught) {
            _showCaptureDialog(context);
          } else {
            context.pushNamed('pokemons', pathParameters: {'name': widget.pokemon.name}, extra: widget.pokemon.id);
          }
        },
        onLongPress: () {
          if (widget.pokemon.isCaught) {
            widget.onFavoriteToggle();
          } else {
            _showUncaughtWarning(context);
          }
        },
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
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: 'pokemon-${widget.pokemon.id}',
                  child: Image.network(
                    'https://img.pokemondb.net/sprites/home/normal/${widget.pokemon.name.toLowerCase()}.png',
                    fit: BoxFit.contain,
                    color: widget.pokemon.isCaught ? null : Colors.black.withValues(alpha: 0.85),
                    colorBlendMode: widget.pokemon.isCaught ? null : BlendMode.srcIn,
                    errorBuilder: (context, error, stackTrace) => const PokeBallIcon(size: 24),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const PokeBallIcon(size: 24);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 6,
                left: 8,
                child: Text(
                  '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withValues(
                      alpha: 0.2,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                left: 8,
                right: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.colorScheme.onSurface, borderRadius: borderRadius16),
                  child: Text(
                    widget.pokemon.isCaught ? _capitalize(widget.pokemon.name) : '???',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: context.colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUncaughtWarning(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Captura a este Pokémon antes de añadirlo a favoritos!',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Palette.pokemonRed,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCaptureDialog(BuildContext outerContext) {
    final controller = TextEditingController();
    final isDark = Theme.of(outerContext).brightness == Brightness.dark;

    showDialog(
      context: outerContext,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(dialogContext).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          '¡Un Pokémon salvaje apareció!',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              width: 120,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.05), shape: BoxShape.circle),
              child: Image.network(
                widget.pokemon.spriteUrl,
                color: Colors.black.withValues(alpha: 0.85),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '¿Cuál es este Pokémon?',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black54),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                hintText: 'Adivina el nombre...',
                hintStyle: GoogleFonts.outfit(fontWeight: FontWeight.w400, color: Colors.grey),
                filled: true,
                fillColor: isDark ? Colors.white12 : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
              onSubmitted: (val) => _validateAndCatch(outerContext, dialogContext, val),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Escapar',
              style: GoogleFonts.outfit(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () => _validateAndCatch(outerContext, dialogContext, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.pokemonRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('¡Lanzar Poké Ball!', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _validateAndCatch(BuildContext outerContext, BuildContext dialogContext, String input) {
    if (input.trim().toLowerCase() == widget.pokemon.name.toLowerCase()) {
      Navigator.pop(dialogContext);
      outerContext.read<CatchPokemonCubit>().catchPokemon(widget.pokemon.id, widget.pokemon.name);

      ScaffoldMessenger.of(outerContext).showSnackBar(
        SnackBar(
          content: Text(
            '¡Excelente! Has capturado a ${widget.pokemon.name.toUpperCase()}!',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        SnackBar(
          content: Text('¡Oh no! No es su nombre correcto.', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
          backgroundColor: Palette.pokemonRed,
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
