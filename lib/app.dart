import 'package:catch_poke_app/ui/pokemons/pages/pokemon_screen.dart';
import 'package:catch_poke_app/ui/pokemons/pokemon/pokemon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => GetIt.I.get<PokemonBloc>()..add(const PokemonEvent.fetchPokemons()),
        child: const PokemonScreen(),
      ),
    );
  }
}
