abstract class PokemonsEndpoints {
  static const String pokemon = 'pokemon';
  static String allByPages(int offset, int limit) =>
      '$pokemon/?offset=$offset&limit=$limit';
  static String byName(String name) => '$pokemon/name';
}
