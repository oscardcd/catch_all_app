abstract class PokemonsEndpoints {
  static const String pokemon = 'pokemon';
  static allByPages(int offset, int limit) => '$pokemon/?offset=$offset&limit=$limit';
  static byName(String name) => '$pokemon/name';
}
