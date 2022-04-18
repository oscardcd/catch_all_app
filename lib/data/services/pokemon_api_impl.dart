import 'package:catch_poke_app/data/api/endpoints.dart';
import 'package:catch_poke_app/data/api/interceptors/api_key_interceptor.dart';
import 'package:catch_poke_app/data/model/all_pokemons.dart';
import 'package:catch_poke_app/data/model/pokemon.dart';
import 'package:catch_poke_app/domain/services/pokemon_api.dart';
import 'package:client_api/api/api_client.dart';
import 'package:client_api/api/model/api_result.dart';
import 'package:client_api/api/request.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Injectable(as: PokemonApi)
class PokemonApiImpl implements PokemonApi {
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
  Future<ApiResult<AllPokemons?>> getAllPokemons(int offSet, int limitPokemons) {
    init();
    return ApiClient.instance.request(
      ApiRequest.get(PokemonsEndpoints.allByPages(offSet, limitPokemons)),
      (j) => AllPokemons.fromJson(j),
    );
  }

  @override
  Future<ApiResult<Pokemon?>> getPokemonByName(String name) {
    // TODO: implement getPokemonByName
    throw UnimplementedError();
  }
}
