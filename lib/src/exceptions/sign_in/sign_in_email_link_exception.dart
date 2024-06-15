/// {@template sign_in_with_email_link_failure}
/// Thrown during the SignIn process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailLink.html
/// {@endtemplate}
class SignInWithEmailLinkException implements Exception {
  /// {@macro sign_in_with_email_link_failure}
  const SignInWithEmailLinkException([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailLinkException.fromCode(String code) {
    switch (code) {
      case 'expired-action-code':
        return const SignInWithEmailLinkException(
          '''The action code has expired. Please resend the verification code to try again.''',
        );
      case 'invalid-email':
        return const SignInWithEmailLinkException(
          'Email is not valid or badly formatted.',
        );
      case 'invalid-email-link':
        return const SignInWithEmailLinkException(
          'The link is not valid.',
        );
      case 'user-disabled':
        return const SignInWithEmailLinkException(
          'This user has been disabled. Please contact support for help.',
        );
      default:
        return const SignInWithEmailLinkException();
    }
  }

  /// The associated error message.
  final String message;

  @override
  String toString() => message;
}
