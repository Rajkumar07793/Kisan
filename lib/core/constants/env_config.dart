import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kisan_app/core/constants/app_assets.dart';

class EnvConfig {
  static String get appName => dotenv.get('APP_NAME', fallback: 'HerStay');
  static String get apiUrl => dotenv.get('API_URL', fallback: '');
  static String get firebaseProjectId =>
      dotenv.get('FIREBASE_PROJECT_ID', fallback: '');

  static bool get isDebug =>
      dotenv.get('DEBUG_MODE', fallback: 'false').toLowerCase() == 'true';

  static String get supabaseUrl => dotenv.get('SUPABASE_URL', fallback: '');
  static String get supabaseAnonKey =>
      dotenv.get('SUPABASE_ANON_KEY', fallback: '');

  static Future<void> init() async {
    await dotenv.load(fileName: AppAssets.env);
  }
}
