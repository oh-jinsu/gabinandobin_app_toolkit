import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/auth_api.dart';
import 'package:gabinandobin_app_toolkit/bootstrapper.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/concretes/api.dart';
import 'package:gabinandobin_app_toolkit/concretes/channel.dart';
import 'package:gabinandobin_app_toolkit/concretes/dialog.dart';
import 'package:gabinandobin_app_toolkit/concretes/navigator.dart';
import 'package:gabinandobin_app_toolkit/concretes/secure_storage.dart';
import 'package:gabinandobin_app_toolkit/config.dart';
import 'package:gabinandobin_app_toolkit/controller.dart';
import 'package:gabinandobin_app_toolkit/dialog.dart';
import 'package:gabinandobin_app_toolkit/event.dart';
import 'package:gabinandobin_app_toolkit/initializer.dart';
import 'package:gabinandobin_app_toolkit/navigator.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';
import 'package:gabinandobin_app_toolkit/storage.dart';
import 'package:gabinandobin_app_toolkit/theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class GOMaterialApp extends StatefulWidget {
  final GOConfig config;

  final GOThemeMode _initialThemeMode;

  GOMaterialApp({
    super.key,
    GOThemeMode initialThemeMode = GOThemeMode.light,
    bool debugMode = false,
    Widget? home,
    Color primaryColor = Colors.blue,
    Color backgroundColor = Colors.white,
    Color linkColor = Colors.blue,
    GOColorScheme? lightColorScheme,
    GOColorScheme? darkColorScheme,
    double fontSize = 16.0,
    String? apiOrigin,
    String? cdnOrigin,
    GOAPI? api,
    GOAuthAPI? authAPI,
    GOBootstrapper? bootstrapper,
    GOInitializer? initializer,
    List<SingleChildWidget> providers = const [],
    GOChannel? channel,
    GONavigator? navigator,
    GOThemeData? theme,
    GOSecureStorage? secureStorage,
    GODialog? dialog,
    Locale? locale,
    Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
  })  : _initialThemeMode = initialThemeMode,
        config = GOConfig(
          debugMode: debugMode,
          home: home,
          cdnOrigin: cdnOrigin,
          api: api ?? (apiOrigin != null ? GODefaultAPI(baseUrl: apiOrigin) : null),
          authAPI: authAPI,
          bootstrapper: bootstrapper,
          initializer: initializer,
          providers: providers,
          channel: channel ?? GODefaultChannel(),
          navigator: navigator ?? GODefaultNavigator(),
          theme: theme ??
              GOThemeData(
                light: lightColorScheme ??
                    GOColorScheme.light(
                      primaryColor: primaryColor,
                      backgroundColor: backgroundColor,
                      linkColor: linkColor,
                    ),
                dark: darkColorScheme ??
                    GOColorScheme.dark(
                      primaryColor: primaryColor,
                      backgroundColor: backgroundColor,
                      linkColor: linkColor,
                    ),
                fontSize: fontSize,
              ),
          secureStorage: secureStorage ?? GODefaultSecureStorage(),
          dialog: dialog ?? GODefaultDialog(),
          locale: locale,
          supportedLocales: supportedLocales,
        );

  @override
  State<GOMaterialApp> createState() => _GOMaterialAppState();
}

class _GOMaterialAppState extends State<GOMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GOConfig>(lazy: false, create: (c) => widget.config),
        Provider<GOChannel>(lazy: false, create: (c) => widget.config.channel),
        Provider<GONavigator>(lazy: false, create: (c) => widget.config.navigator),
        Provider<GOSecureStorage>(lazy: false, create: (c) => widget.config.secureStorage),
        GOControllerProvider<GOThemeController>(
          controller: GOThemeController(
            data: widget.config.theme,
            mode: widget._initialThemeMode,
          ),
        ),
        if (widget.config.bootstrapper != null)
          GOControllerProvider<GOBootstrapper>(controller: widget.config.bootstrapper!),
        if (widget.config.initializer != null)
          GOControllerProvider<GOInitializer>(controller: widget.config.initializer!),
        if (widget.config.api != null) Provider<GOAPI>(lazy: false, create: (c) => widget.config.api!),
        if (widget.config.authAPI != null) Provider<GOAuthAPI>(lazy: false, create: (c) => widget.config.authAPI!),
        ...widget.config.providers
      ],
      child: Consumer<GOThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: widget.config.debugMode,
            navigatorKey: GO.navigatorKey,
            home: widget.config.bootstrapper == null && widget.config.initializer == null
                ? widget.config.home
                : const GOInitialPage(),
            theme: themeController.generateThemeData(),
            locale: widget.config.locale,
            supportedLocales: widget.config.supportedLocales,
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
          );
        },
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GO.dispatch(const GOAppReadyEvent());

      GO.log("App ready");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
