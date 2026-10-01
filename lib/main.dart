import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/router/app_router.dart';
import 'app/services/server_time_service.dart';
import 'app/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Sync verified online server time in background
  ServerTimeService.syncOnlineTime();
  
  initializeDateFormatting('tr_TR', null).catchError((e) {
    debugPrint('Date formatting initialization note: $e');
  });
  initializeDateFormatting('tr', null).catchError((e) {
    debugPrint('Date formatting initialization note: $e');
  });

  try {
    final options = DefaultFirebaseOptions.currentPlatform;
    await Firebase.initializeApp(options: options).timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        debugPrint('Firebase initialization timed out, proceeding with app launch');
        return Firebase.app();
      },
    );
  } catch (e) {
    debugPrint('Firebase initialization note: $e');
  }

  runApp(
    const ProviderScope(
      child: KnowUpApp(),
    ),
  );
}

class KnowUpApp extends ConsumerWidget {
  const KnowUpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'KnowUp - Öğren. Pekiştir. Ustalaş.',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
