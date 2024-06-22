import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {

  static Future<void> load() => dotenv.load(fileName: '.env');

  static String get apiBaseUrl => dotenv.get('API_BASE_URL');
}
