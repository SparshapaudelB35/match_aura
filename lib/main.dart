import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:match_aura/app/app.dart';
import 'package:match_aura/core/services/hive/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hiveService = HiveService();
  
  await hiveService.init(); 

  runApp(
    ProviderScope(
      overrides: [
        hiveServiceProvider.overrideWithValue(hiveService),
      ],
      child: const MyApp(),
    ),
  );
}
