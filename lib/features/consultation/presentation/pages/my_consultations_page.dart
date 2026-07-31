import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class MyConsultationsPage extends StatelessWidget {
  const MyConsultationsPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const MyConsultationsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBarWidget(title: 'My Consultations'));
  }
}
