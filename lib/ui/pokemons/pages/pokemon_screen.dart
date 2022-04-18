import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:catch_poke_app/domain/use_case/pokemon_use_case.dart';
import 'package:catch_poke_app/ui/pokemons/pokemon/pokemon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({Key? key}) : super(key: key);

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
