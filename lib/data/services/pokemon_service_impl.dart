import 'package:catch_all_app/data/interceptors/api_key_interceptor.dart';
import 'package:catch_all_app/data/endpoints/endpoints.dart';
import 'package:catch_all_app/domain/entities/all_pokemons.dart';
import 'package:catch_all_app/domain/entities/pokemon.dart';
import 'package:catch_all_app/domain/services/pokemon_service.dart';
import 'package:client_api/client_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PokemonServiceImpl implements PokemonService {
  static const Map<String, Object> _defaultHeaders = {'content-Type': 'application/json'};
  static const _baseUrl = 'https://pokeapi.co/api/v2/';

  void init() {
    ApiClient.instance.init(
      baseUrl: _baseUrl,
      headers: _defaultHeaders,
      interceptors: [PrettyDioLogger(), ApiKeyInterceptor()],
    );
  }

  @override
  Future<ApiResult<AllPokemons?>> getAllPokemons(int offSet, int limitPokemons) async {
    init();
    return await ApiClient.instance.request(
      ApiRequest.get(PokemonsEndpoints.allByPages(offSet, limitPokemons)),
      (j) => AllPokemons.fromJson(j),
    );
  }

  @override
  Future<ApiResult<Pokemon?>> getPokemonByName(String name) async {
    init();
    return ApiClient.instance.request(
      ApiRequest.get(PokemonsEndpoints.byName(name)),
      (j) => Pokemon.fromJson(j),
    );
  }
}
