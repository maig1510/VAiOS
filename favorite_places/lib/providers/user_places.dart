import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import '../models/place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [];
  }

  Future<void> loadPlaces() async {
    // 1. Prečítaj dáta z databázy (najnovšie navrchu, rovnako ako pri pridávaní)
    final db = await _getDatabase();
    final data = await db.query('user_places', orderBy: 'rowid DESC');

    // 2. Transformuj záznamy na objekty Place
    final loadedPlaces = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    // 3. Aktualizuj stav
    state = [...loadedPlaces];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    // 1. Získanie aplikáciou vlastneného adresára
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    // 2. Extrahovanie názvu súboru z pôvodnej cesty
    final fileName = path.basename(image.path);

    // 3. Kopírovanie obrázka do perzistentného úložiska
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    // 4. Použitie copiedImage namiesto image
    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    // 5. Uloženie údajov o mieste do SQLite databázy
    final db = await _getDatabase();
    await db.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': copiedImage.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    NotifierProvider<UserPlacesNotifier, List<Place>>(
  UserPlacesNotifier.new,
);
