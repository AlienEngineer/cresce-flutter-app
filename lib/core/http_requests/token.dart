import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';

class Token extends Equatable implements Serializable, Deserialize {
  final String token;

  Token({this.token});

  @override
  String serialize(Encoder encoder) {
    return encoder.encode(toMap());
  }

  @override
  Object deserialize(Map<String, dynamic> data) {
    return fromMap(data);
  }

  Object fromMap(Map<String, Object> map) {
    return Token(
      token: map['token'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'token': token,
    };
  }

  @override
  List<Object> get props => [token];

  String toBearer() => 'bearer $token';
}
