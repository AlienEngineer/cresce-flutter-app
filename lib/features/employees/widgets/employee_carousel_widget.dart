import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:cresce_flutter_app/service_configuration.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class EmployeeCarouselWidget extends StatefulWidget {
  @override
  _EmployeeCarouselWidgetState createState() => _EmployeeCarouselWidgetState();
}

class _EmployeeCarouselWidgetState extends State<EmployeeCarouselWidget> {
  Widget _current = Container();

  @override
  void initState() {
    super.initState();

    context
        .get<EmployeeServices>()
        .getEmployees(Organization(name: 'myOrganization'))
        .then((employees) {
      _current = _makeCarousel(employees);
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    return _current;
  }
}
