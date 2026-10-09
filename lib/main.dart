// AfriDelight
// Developed by Devmaes.
//
// Entry point kept intentionally small. Application composition lives in
// lib/app/afridelight_app.dart.

import 'package:afridelight/app/afridelight_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AfriDelightApp()));
}
