/// Thrown when a dependency is missing.
class MissingDependenciesException implements Exception {
  /// Thrown when google sign in dependency is missing.
  MissingDependenciesException.googleSignIn() : dependencyName = 'GoogleSignIn';

  /// The name of missing dependency.
  final String dependencyName;

  @override
  String toString() => 'Missing dependency: $dependencyName ';
}
