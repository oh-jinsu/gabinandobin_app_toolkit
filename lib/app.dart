import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/concretes/channel.dart';
import 'package:gabinandobin_app_toolkit/concretes/navigator.dart';
import 'package:gabinandobin_app_toolkit/concretes/secure_storage.dart';
import 'package:gabinandobin_app_toolkit/event.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';
import 'package:gabinandobin_app_toolkit/navigator.dart';
import 'package:gabinandobin_app_toolkit/storage.dart';
import 'package:gabinandobin_app_toolkit/theme.dart';
import 'package:provider/provider.dart';

class GOApp extends StatefulWidget {
  final bool debugMode;

  final Color primaryColor;

  final Widget? home;

  final GONavigator navigator;

  final GOSecureStorage storage;

  final GOChannel channel;

  final ThemeData theme;

  final GOAPI api;

  final GOAuthAPI? authApi;

  final List<GOSubscriber> subscribers;

  GOApp({
    super.key,
    this.debugMode = false,
    this.home,
    required this.api,
    this.primaryColor = Colors.blue,
    this.authApi,
    this.subscribers = const [],
    GOChannel? channel,
    GONavigator? navigator,
    ThemeData? theme,
    GOSecureStorage? secureStorage,
  })  : channel = channel ?? GODefaultChannel(),
        navigator = navigator ?? GODefaultNavigator(),
        storage = secureStorage ?? GODefaultSecureStorage(),
        theme = theme ?? createTheme(primaryColor: primaryColor) {
    GO.debugMode = debugMode;
  }

  @override
  State<GOApp> createState() => _GOAppState();
}

class _GOAppState extends State<GOApp> {
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    for (final subscriber in widget.subscribers) {
      final subscription = widget.channel.stream.listen(subscriber.onListen);

      _subscriptions.add(subscription);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.channel.dispatch(const GOAppReadyEvent());
    });

    super.initState();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GOChannel>.value(value: widget.channel),
        Provider<GONavigator>.value(value: widget.navigator),
        Provider<GOAPI>.value(value: widget.api),
        Provider<GOSecureStorage>.value(value: widget.storage),
        if (widget.authApi != null) Provider<GOAuthAPI>.value(value: widget.authApi!),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: widget.debugMode,
        navigatorKey: GO.navigatorKey,
        home: widget.home ?? const GOInitialPage(),
        theme: widget.theme,
      ),
    );
  }
}

class GOInitialPage extends StatefulWidget {
  const GOInitialPage({super.key});

  @override
  State<GOInitialPage> createState() => _GOInitialPageState();
}

class _GOInitialPageState extends State<GOInitialPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
