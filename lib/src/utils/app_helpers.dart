abstract final class AppHelpers {
  /// Returns value from [getThrowableValue] or [getDefaultValue] if [getThrowableValue] throws an exception.
  static T tryGet<T>(T Function() getThrowableValue, T Function() getDefaultValue) {
    try {
      return getThrowableValue();
    } catch (e) {
      return getDefaultValue();
    }
  }
}
