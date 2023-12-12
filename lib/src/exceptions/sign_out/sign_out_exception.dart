/// {@template sign_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class SignOutException implements Exception {
  /// {@macro sign_out_failure}
  const SignOutException();

  @override
  String toString() => 'Failed to sign out.';
}
