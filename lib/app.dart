import 'package:oyt_front_core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_chef/core/router/router.dart';
import 'package:oyt_front_core/push_notifications/push_notif_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    final pushNotification = PushNotificationProvider(messengerKey: _messangerKey);
    pushNotification.setupInteractedMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routerProv = ref.read(routerProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: _messangerKey,
      title: 'OYT - Chef',
      routerConfig: routerProv.goRouter,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.myTheme(),
    );
  }
}
