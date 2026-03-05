abstract class AuthEndpoints {
  static const String login = 'auth/login';
}

abstract class PokemonsEndpoints {
  static String allByPages(int offset, int limit) => 'pokemon/?offset=$offset&limit=$limit';
  static String byName(String name) => 'pokemon/$name';
}
