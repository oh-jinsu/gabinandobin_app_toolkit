import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/auth_api.dart';
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
import 'package:provider/single_child_widget.dart';

class GOApp extends StatefulWidget {
  final bool debugMode;

  final Color primaryColor;

  final Widget? home;

  final GONavigator navigator;

  final GOSecureStorage storage;

  final GOChannel channel;

  final ThemeData theme;

  final GOAPI? api;

  final GOAuthAPI? authApi;

  final List<GOSubscriber> subscribers;

  final List<SingleChildWidget> providers;

  GOApp({
    super.key,
    this.debugMode = false,
    this.home,
    this.api,
    this.primaryColor = Colors.blue,
    this.authApi,
    this.subscribers = const [],
    this.providers = const [],
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
        Provider<GOChannel>(lazy: false, create: (c) => widget.channel),
        Provider<GONavigator>(lazy: false, create: (c) => widget.navigator),
        if (widget.api != null) Provider<GOAPI>(lazy: false, create: (c) => widget.api!),
        Provider<GOSecureStorage>(lazy: false, create: (c) => widget.storage),
        if (widget.authApi != null) Provider<GOAuthAPI>(lazy: false, create: (c) => widget.authApi!),
        ...widget.providers
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
