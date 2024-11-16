import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'homepage.dart';

Future<void> main() async {
  const keyApplicationId = 'dqZBCoWIex7uTx8M0CRlOnzKKADF0qclYmzZxQgM';
  const keyClientKey = '1tskL2gxTlMponvEMYh95eYFP2F2JjJTiT23cjdk';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(41, 50, 62, 1),
          ),
        scaffoldBackgroundColor: const Color.fromRGBO(41, 50, 62, 1)
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      home: const HomePage(),
    );
  }
}