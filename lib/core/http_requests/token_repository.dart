import 'package:cresce_flutter_app/core/core.dart';

class TokenRepository {
  Token _token;

  void store(Token token) => _token = token;

  Token getToken() => _token;
}
