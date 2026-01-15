import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:match_aura/app/app.dart';
import 'package:match_aura/core/services/hive/hive_service.dart';
import 'package:match_aura/core/services/storage/user_session_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hiveService = HiveService();
  
  await hiveService.init(); 

  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        hiveServiceProvider.overrideWithValue(hiveService),
        SharedPreferencesProvider.overrideWithValue(sharedPrefs)
      ],
      child: const MyApp(),
    ),
  );
}
