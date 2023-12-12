/// {@template sign_in_anonymous_failure}
/// Thrown during the sign in anonymousely if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInAnonymously.html
/// {@endtemplate}
class SignInAnonymouslyException implements Exception {
  /// {@macro sign_in_anonymous_failure}
  const SignInAnonymouslyException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInAnonymouslyException.fromCode(String code) {
    switch (code) {
      case 'operation-not-allowed':
        return const SignInAnonymouslyException(
          'Operation is not allowed.  Please contact support.',
        );
      default:
        return const SignInAnonymouslyException();
    }
  }

  /// The associated error message.
  final String message;

  @override
  String toString() => message;
}
