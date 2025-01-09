class DateChecker {
  /// Checks if the given date is within the last 24 hours from the current time.
  ///
  /// This method parses the provided [date] string into a [DateTime] object and
  /// calculates the difference between the current time and the parsed date.
  /// If the difference is less than 24 hours, it returns `true`, indicating that
  /// editing is allowed. If the [date] string is empty, it also returns `true`.
  ///
  /// - Parameter date: A string representing the date to be checked.
  /// - Returns: A boolean value indicating whether editing is allowed within 24 hours.
  static bool check24hEditAllow(String date) {
    if (date.isEmpty) return true;
    final now = DateTime.now();
    final createdAt = DateTime.parse(date);
    final difference = now.difference(createdAt);
    return difference.inHours < 24;
  }
}
