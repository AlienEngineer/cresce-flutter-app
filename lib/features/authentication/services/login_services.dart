import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';

typedef OnLoginSuccessful(Token result);
typedef OnLoginFailure();

class LoginServices {
  final HttpPost httpPost;
  final TokenRepository _tokenRepository;

  const LoginServices(this.httpPost, this._tokenRepository);

  void login(
    Credentials credentials, {
    OnLoginSuccessful onSuccess,
    OnLoginFailure onFailure,
  }) {
    httpPost.postElement(
      url: 'api/v1/authentication/',
      body: credentials,
      onSuccess: (token) {
        _tokenRepository.store(token);
        onSuccess(token);
      },
      onFailure: onFailure,
      deserialize: Token(),
    );
  }
}
