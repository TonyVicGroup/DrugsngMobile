import 'dart:developer';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Prints messages only in **Debug** mode
void dLog(dynamic message) {
  if (kDebugMode) log(message.toString());
}
