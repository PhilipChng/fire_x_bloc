import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth_bloc/src/services/services.dart';

/// {@template firebase_auth_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class FirebaseAuthRepository {
  /// {@macro firebase_auth_repository}
  FirebaseAuthRepository({
    required FirebaseAuth firebaseAuth,
    GoogleSignIn? googleSignIn,
    SignInService? signInService,
    SignOutService? signOutService,
    SignUpService? signUpService,
  })  : _signInService = signInService ??
            SignInService(
              firebaseAuth: firebaseAuth,
              googleSignIn: googleSignIn,
            ),
        _signOutService = signOutService ??
            SignOutService(
              firebaseAuth: firebaseAuth,
              googleSignIn: googleSignIn,
            ),
        _signUpService = signUpService ??
            SignUpService(
              firebaseAuth: firebaseAuth,
            );

  final SignInService _signInService;
  final SignOutService _signOutService;
  final SignUpService _signUpService;

  /// Signs up with the provided [email] and [password].
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _signUpService.emailAndPassword(email: email, password: password);
  }

  /// Signs in with the provided [email] and [password].
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _signInService.emailAndPassword(email: email, password: password);
  }

  /// Starts the Sign In with Google Flow.
  Future<void> signInWithGoogle() async {
    await _signInService.google();
  }

  /// Signs in with an anonymous account.
  Future<void> signInAnonymously() async {
    await _signInService.anonymous();
  }

  /// Signs out from all providers.
  Future<void> signOut() async {
    unawaited(_signOutService.google());
    unawaited(_signOutService.firebase());
  }
}
