import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';

class Organization extends Equatable implements Deserialize {
  final String name;

  Organization({
    this.name,
  });

  @override
  List<Object> get props => [name];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Organization(
      name: map['name'],
    );
  }

  @override
  Object deserialize(Map<String, dynamic> map) {
    return fromMap(map);
  }
}

class OrganizationList implements Serializable, Deserialize {
  List<Organization> list;

  OrganizationList([this.list]);

  @override
  String serialize(Encoder encoder) {
    return encoder.encodeList(
      list.map((obj) => obj.toMap()).toList(),
    );
  }

  @override
  Object deserialize(dynamic data) {
    var list = data as List;
    return list.map((item) => Organization().fromMap(item)).toList();
  }
}
