import 'package:catch_all_app/ui/pokemon_details/bloc/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen._();

  static const String route = '/pokemons';
  static const String name = 'pokemons';

  static Widget builder(BuildContext _, GoRouterState __) {
    return const PokemonDetailScreen._();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PokemonBloc, PokemonState>(
        listener: _listener,
        child: BlocBuilder<PokemonBloc, PokemonState>(
          buildWhen: (previous, current) => previous != current,
          builder: (_, state) {
            return state.maybeWhen(
                pokemonsLoaded: (pokemons) => Column(
                      children: List.generate(
                          pokemons.length,
                          (index) => Wrap(
                                children: [
                                  Column(
                                    children: [Text(pokemons[index].name ?? 'no name')],
                                  )
                                ],
                              )),
                    ),
                orElse: () => SizedBox.shrink());
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, PokemonState state) {}
}
