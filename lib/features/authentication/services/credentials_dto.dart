import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';

class CredentialsDto extends Equatable implements Serializable {
  final String user;
  final String password;

  CredentialsDto({
    this.user,
    this.password,
  });

  @override
  String serialize(Encoder encoder) {
    return encoder.encode(toMap());
  }

  @override
  List<Object> get props => [user, password];

  Map<String, Object> toMap() {
    return {
      'user': user,
      'password': password,
    };
  }
}
