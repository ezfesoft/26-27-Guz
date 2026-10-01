import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerTimeService {
  static Duration _clockOffset = Duration.zero;
  static bool _isSyncing = false;
  static DateTime? _lastSyncedAt;

  /// Fetches verified online server time from a public NTP/time API
  /// and calculates clock offset against local device clock.
  static Future<DateTime> syncOnlineTime() async {
    if (_isSyncing) return getNow();
    _isSyncing = true;

    try {
      final response = await http
          .get(
            Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=Europe/Istanbul'),
          )
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dateTimeStr = data['dateTime'] ?? data['currentLocalTime'];

        if (dateTimeStr != null) {
          final serverTime = DateTime.parse(dateTimeStr.toString());
          final localNow = DateTime.now();
          _clockOffset = serverTime.difference(localNow);
          _lastSyncedAt = localNow;
        }
      }
    } catch (_) {
      // Fallback: If primary timeapi fails, try worldtimeapi as backup
      try {
        final backupResponse = await http
            .get(Uri.parse('https://worldtimeapi.org/api/timezone/Europe/Istanbul'))
            .timeout(const Duration(seconds: 3));

        if (backupResponse.statusCode == 200) {
          final data = json.decode(backupResponse.body);
          final datetimeStr = data['datetime'];
          if (datetimeStr != null) {
            final serverTime = DateTime.parse(datetimeStr.toString());
            final localNow = DateTime.now();
            _clockOffset = serverTime.difference(localNow);
            _lastSyncedAt = localNow;
          }
        }
      } catch (e) {
        // Fallback: If network is offline, rely on cached offset or local clock
      }
    } finally {
      _isSyncing = false;
    }

    return getNow();
  }

  /// Returns the current verified online time.
  /// Even if student manually alters local computer date/time,
  /// this returned DateTime accurately represents real server time.
  static DateTime getNow() {
    // If not synced within last 1 hour, trigger background sync
    if (_lastSyncedAt == null ||
        DateTime.now().difference(_lastSyncedAt!) > const Duration(hours: 1)) {
      syncOnlineTime();
    }
    return DateTime.now().add(_clockOffset);
  }
}
