import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:auth_repo/src/services/services.dart';

/// {@template auth_repo}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthRepo {
  /// {@macro auth_repo}
  AuthRepo({
    required FirebaseAuth firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _googleSignIn = googleSignIn,
        _signInService = SignInService(
          firebaseAuth: firebaseAuth,
          googleSignIn: googleSignIn,
        ),
        _signOutService = SignOutService(
          firebaseAuth: firebaseAuth,
          googleSignIn: googleSignIn,
        ),
        _signUpService = SignUpService(
          firebaseAuth: firebaseAuth,
        );

  final SignInService _signInService;
  final SignOutService _signOutService;
  final SignUpService _signUpService;

  final GoogleSignIn? _googleSignIn;

  /// Signs up with the provided [email] and [password].
  Future<void> signUpWithEmailAndPassword(String email, String password) {
    return _signUpService.emailAndPassword(email: email, password: password);
  }

  /// Signs in with the provided [email] and [password].
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _signInService.emailAndPassword(email: email, password: password);
  }

  /// Starts the Sign In with Google Flow.
  Future<void> signInWithGoogle() {
    return _signInService.google();
  }

  /// Signs in with an anonymous account.
  Future<void> signInAnonymously() {
    return _signInService.anonymous();
  }

  /// Signs out from all providers.
  Future<void> signOut() async {
    if (_googleSignIn != null) await _signOutService.google();
    await _signOutService.firebase();
  }
}
