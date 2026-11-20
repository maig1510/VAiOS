/// Google Maps API kľúč.
///
/// Hodnota sa načíta pri builde zo súboru `.env` v koreni projektu:
///   flutter run --dart-define-from-file=.env
/// Samotný kľúč tak nie je nikde v zdrojovom kóde.
const mapsApiKey = String.fromEnvironment('MAPS_API_KEY');
