import 'dart:developer' as developer;

/// Extension on Object to provide debug print functionality for any data type
extension DebugExtension<T> on T {
  /// Prints the object to the console and returns the object itself
  /// This allows for chaining in expressions
  ///
  /// Example usage:
  /// ```dart
  /// // Simple usage
  /// final user = User(name: 'John').debug();
  ///
  /// // Chained usage
  /// final result = calculateValue().debug().transform();
  ///
  /// // With custom label
  /// final items = fetchItems().debug('Fetched items');
  ///
  /// // With custom formatter
  /// final user = User(name: 'John').debug(
  ///   formatter: (u) => 'User: ${u.name}',
  /// );
  /// ```
  T tk421([String? label, String Function(T)? formatter]) {
    final String output = formatter != null ? formatter(this) : toString();

    final String prefix = label != null ? '[$label] ' : '';

    // Use developer.log for better formatting in DevTools
    developer.log('$prefix$output');

    // Return the object itself to allow for chaining
    return this;
  }
}
