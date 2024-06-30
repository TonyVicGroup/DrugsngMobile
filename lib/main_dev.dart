import 'package:drugs_ng/src/core/utils/environment.dart';
import 'package:drugs_ng/src/main_common.dart';
import 'package:drugs_ng/src/app.dart';
import 'package:flutter/material.dart';

void main() async {
  AppEnvironment.setupEnv(Environment.dev);
  await setupMain();
  runApp(const MyApp());
}
