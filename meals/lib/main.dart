import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  // fialovo-žltá téma: fialový základ, žlté akcenty
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 103, 58, 183), // fialová
    primary: const Color.fromARGB(255, 255, 202, 40), // žltá
    tertiary: const Color.fromARGB(255, 255, 202, 40), // žltá (prepínače filtrov)
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      // slovenčina aj pre vstavané texty Flutteru (napr. tooltipy tlačidiel)
      locale: const Locale('sk'),
      supportedLocales: const [Locale('sk')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const TabsScreen(),
    );
  }
}
