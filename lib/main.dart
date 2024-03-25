import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/const/theme_dark.dart';
import 'package:rg_track/firebase_options.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/routes.dart';
import 'package:rg_track/utils/scroll.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //kIsWeb ? setUrlStrategy(null) : null;
  injectionSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      scrollBehavior: AppScrollBehavior(),
      title: 'RG Track - Admin',
      theme: theme(),
      darkTheme: darkTheme(),
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
    );
  }
}
