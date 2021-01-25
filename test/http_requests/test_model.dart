import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';

class TestModel implements Serializable, Deserialize {
  @override
  String serialize(Encoder encoder) {
    return encoder.encode({
      'test': 'data',
    });
  }

  @override
  Object deserialize(Object data) {
    return this;
  }
}
