// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/repositories/pokemon_repository_impl.dart' as _i6;
import 'data/services/pokemon_api_impl.dart' as _i4;
import 'domain/repositories/pokemon_repository.dart' as _i5;
import 'domain/services/pokemon_api.dart' as _i3;
import 'domain/use_case/pokemon_use_case.dart' as _i7;
import 'ui/pokemons/pokemon/pokemon_bloc.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.PokemonApi>(() => _i4.PokemonApiImpl());
  gh.factory<_i5.PokemonRepository>(
      () => _i6.PokemonRepositoryImpl(get<_i3.PokemonApi>()));
  gh.factory<_i7.PokemonUseCase>(
      () => _i7.PokemonUseCaseImpl(get<_i5.PokemonRepository>()));
  gh.factory<_i8.PokemonBloc>(() => _i8.PokemonBloc(get<_i7.PokemonUseCase>()));
  return get;
}
