import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/service_configuration.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeeCarouselWidget extends StatefulWidget {
  @override
  _EmployeeCarouselWidgetState createState() => _EmployeeCarouselWidgetState();
}

class _EmployeeCarouselWidgetState extends State<EmployeeCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return DataBuilder<List<Employee>>(
      future: getEmployees(context),
      onData: (data) => _makeCarousel(data),
    );
  }

  Widget _makeCarousel(List<Employee> employees) {
    return BitCarousel(
      children: employees.map((e) {
        return BitThumbnail(
          width: 200,
          data: ThumbnailData(
            title: e.name,
            subTitle: e.title,
            image: Future.value(e.image),
          ),
        );
      }).toList(),
    );
  }

  Future<List<Employee>> getEmployees(BuildContext context) {
    return context
        .get<EmployeeServices>()
        .getEmployees(Organization(name: 'myOrganization'));
  }
}
