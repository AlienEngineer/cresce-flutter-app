import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeeServices {
  HttpGet httpGet;

  EmployeeServices(this.httpGet);

  Future<List<Employee>> getEmployees(Organization organizationDto) async {
    return await httpGet.getList<Employee>(
      url: _makePath(organizationDto),
      deserialize: Employee(),
    );
  }

  String _makePath(Organization organizationDto) =>
      'api/v1/organization/${organizationDto.name}/employees';
}

class Employee extends Equatable implements Deserialize {
  final String name;
  final String title;
  final BitImage image;

  Employee({
    this.name,
    this.title,
    this.image,
  });

  @override
  List<Object> get props => [name, title];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'image': image.toBase64(),
    };
  }

  Object fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'],
      title: map['title'],
      image: BitImageBase64(map['image']),
    );
  }

  @override
  Object deserialize(Map<String, dynamic> data) {
    return fromMap(data);
  }
}

class EmployeeList implements Serializable, Deserialize {
  List<Employee> list;

  EmployeeList([this.list]);

  @override
  String serialize(Encoder encoder) {
    return encoder.encodeList(
      list.map((obj) => obj.toMap()).toList(),
    );
  }

  @override
  Object deserialize(dynamic data) {
    var list = data as List;
    return list.map((item) => Employee().fromMap(item)).toList();
  }
}
