/// {@template log_in_with_email_and_password_failure}
/// Thrown during the SignIn process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class SignInWithEmailAndPasswordException implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const SignInWithEmailAndPasswordException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailAndPasswordException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordException(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordException(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordException();
    }
  }

  /// The associated error message.
  final String message;

  @override
  String toString() => message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class SignInWithGoogleException implements Exception {
  /// {@macro log_in_with_google_failure}
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
