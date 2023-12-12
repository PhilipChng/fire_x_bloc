import 'package:firebase_auth/firebase_auth.dart';

import 'package:auth_repo/src/exceptions/exceptions.dart';

/// {@template sign_up_service}
/// Service for signing up.
/// {@endtemplate}
class SignUpService {
  /// {@macro sign_up_service}
  SignUpService({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  /// Signs up with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordException] if an exception occurs.
  Future<void> emailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordException();
    }
  }
}
