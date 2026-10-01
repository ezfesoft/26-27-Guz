/// Global application configuration.
/// Toggle [testMode] to bypass week lock dates for testing purposes.
class AppConfig {
  AppConfig._();

  /// When true, ALL weeks across ALL courses are unlocked regardless of date.
  /// Set to false for production.
  static bool testMode = false;
}
