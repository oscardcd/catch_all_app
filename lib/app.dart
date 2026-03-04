import 'package:catch_all_app/ui/pokemons/screens/pokemon_detail_screen.dart';
import 'package:catch_all_app/ui/pokemons/bloc/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            GetIt.I.get<PokemonBloc>()..add(const PokemonEvent.fetchPokemons()),
        child: const PokemonDetailScreen(),
      ),
    );
  }
}
