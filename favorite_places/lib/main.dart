import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'env.dart';
import 'screens/places.dart';

// Fialovo-žltá téma: fialové plochy a pozadie, žlté akcenty
const purpleDark = Color.fromARGB(255, 38, 12, 74); // pozadie obrazoviek
const purple = Color.fromARGB(255, 88, 28, 160); // AppBar, plochy
const yellow = Color.fromARGB(255, 255, 214, 0); // akcenty, tlačidlá

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  primary: yellow,
  onPrimary: purpleDark,
  secondary: yellow,
  onSecondary: purpleDark,
  surface: purple,
  background: purpleDark,
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: purple,
    foregroundColor: yellow,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: yellow,
      foregroundColor: purpleDark,
    ),
  ),
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
  ),
);

void main() {
  if (mapsApiKey.isEmpty) {
    debugPrint(
      '⚠️ MAPS_API_KEY chýba – spusti: flutter run --dart-define-from-file=.env',
    );
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Places',
      theme: theme,
      home: const PlacesScreen(),
    );
  }
}
