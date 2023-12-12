/// Thrown when a dependency is missing.
class MissingDependencyException implements Exception {
  /// Thrown when google sign in dependency is missing.
  MissingDependencyException.googleSignIn() : dependencyName = 'GoogleSignIn';

  /// The name of missing dependency.
  final String dependencyName;

  @override
  String toString() => 'Missing dependency: $dependencyName ';
}
