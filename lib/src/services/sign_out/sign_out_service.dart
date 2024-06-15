import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:auth_repo/src/exceptions/exceptions.dart';

/// {@template sign_out_service}
/// Service for signing out.
/// {@endtemplate}
class SignOutService {
  /// {@macro sign_out_service}
  SignOutService({
    required FirebaseAuth firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

  /// Signs out from Firebase Auth.
  ///
  /// Throws a [SignOutException] if an exception occurs.
  Future<void> firebase() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw const SignOutException();
    }
  }

  /// Signs out from Google OAuth.
  ///
  /// Throws a [SignOutException] if an exception occurs.
  Future<void> google() async {
    if (_googleSignIn == null) return;

    try {
      await _googleSignIn!.signOut();
    } catch (e) {
      throw const SignOutException();
    }
  }
}
