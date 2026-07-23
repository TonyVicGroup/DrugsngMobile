import 'package:drugs_ng/core/widgets/lab_appbar.dart';
import 'package:flutter/material.dart';

class LabAppointmentDetailScreen extends StatelessWidget {
  const LabAppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LabAppbar(),
      body: ListView(children: const []),
    );
  }
}
