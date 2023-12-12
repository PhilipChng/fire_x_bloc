import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:auth_repo/src/exceptions/exceptions.dart';

/// {@template sign_in_service}
/// Service for signing in.
/// {@endtemplate}
class SignInService {
  /// {@macro sign_in_service}
  SignInService({
    required FirebaseAuth firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [SignInWithEmailAndPasswordException] if an exception occurs.
  Future<UserCredential> emailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordException();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [SignInWithGoogleException] if an exception occurs.
  Future<UserCredential> google() async {
    if (_googleSignIn == null) {
      throw MissingDependencyException.googleSignIn();
    }

    try {
      final googleUser = await _googleSignIn?.signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(code: 'user-cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SignInWithGoogleException.fromCode(e.code);
    } catch (e) {
      throw const SignInWithGoogleException();
    }
  }

  /// Signs in with an anonymous account.
  ///
  /// Throws a [SignInAnonymouslyException] if an exception occurs.
  Future<UserCredential> anonymous() async {
    try {
      return await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw SignInAnonymouslyException.fromCode(e.code);
    } catch (e) {
      throw const SignInAnonymouslyException();
    }
  }
}
