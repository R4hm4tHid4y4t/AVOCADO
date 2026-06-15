class AppConstants {
  AppConstants._();

  // ============================================================
  // PENTING: Sesuaikan baseUrl berdasarkan device yang digunakan
  // ============================================================
  //
  // 1. EMULATOR ANDROID (AVD)
  //    static const String baseUrl = 'http://10.0.2.2:8000';
  //
  // 2. HP FISIK via Wireless Debugging (SATU JARINGAN WIFI)
  //    Gunakan IP adapter "Wireless LAN adapter Wifi" dari ipconfig
  //    (BUKAN adapter Ethernet/VMware/VirtualBox)
  //    static const String baseUrl = 'http://10.20.27.160:8000';
  //
  // 3. WEB / WINDOWS DESKTOP
  //    static const String baseUrl = 'http://localhost:8000';
  //
  // Cara cek IP yang benar:
  //   1. Jalankan 'ipconfig' di PowerShell
  //   2. Cari adapter WiFi yang punya "Default Gateway" terisi
  //      (adapter lain seperti Ethernet/VMware biasanya kosong)
  //   3. Gunakan IPv4 Address dari adapter tersebut
  // ============================================================

  static const String baseUrl = 'http://10.20.27.160:8000';
  static const String apiUrl = '$baseUrl/api';
  static const String storageUrl = '$baseUrl/storage';

  // App Info
  static const String appName = 'Alpukat CNN';
  static const String appVersion = '1.0.0';
  static const String appAuthor = 'Rahmat Hidayat';

  // Storage Keys (flutter_secure_storage)
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';

  // SharedPreferences Keys
  static const String onboardingKey = 'onboarding_done';

  // Pagination
  static const int defaultPerPage = 10;

  // Timeout
  static const int connectTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;
}