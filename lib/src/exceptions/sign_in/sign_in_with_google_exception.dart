/// {@template sign_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class SignInWithGoogleException implements Exception {
  /// {@macro sign_in_with_google_failure}
  const SignInWithGoogleException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithGoogleException.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleException(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const SignInWithGoogleException(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const SignInWithGoogleException(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const SignInWithGoogleException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithGoogleException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithGoogleException(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SignInWithGoogleException(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SignInWithGoogleException(
          'The credential verification ID received is invalid.',
        );
      case 'user-cancelled':
        return const SignInWithGoogleException(
          'User has cancelled the action.',
        );
      default:
        return const SignInWithGoogleException();
    }
  }

  /// The associated error message.
  final String message;

  @override
  String toString() => message;
}
