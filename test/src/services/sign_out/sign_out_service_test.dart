// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:auth_repo/auth_repo.dart';
import 'sign_out_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<GoogleSignIn>(),
])
void main() {
  group('SignOutService', () {
    late MockFirebaseAuth firebaseAuth;
    late MockGoogleSignIn googleSignIn;
    late SignOutService signOutService;
    late SignOutService signOutServiceWithoutGoogle;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      signOutService = SignOutService(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      );
      signOutServiceWithoutGoogle = SignOutService(
        firebaseAuth: firebaseAuth,
      );
    });

    group('firebase', () {
      test('successfully', () async {
        when(firebaseAuth.signOut()).thenAnswer((_) => Future.value());

        try {
          await signOutService.firebase();
        } catch (e) {
          fail('Did not pass as expected');
        }

        verify(firebaseAuth.signOut()).called(1);
      });

      test('throws SignOutException', () async {
        when(firebaseAuth.signOut()).thenThrow(Exception());

        try {
          await signOutService.firebase();
          fail('Did not throw as expected');
        } catch (e) {
          expect(e, isA<SignOutException>());
        }

        verify(firebaseAuth.signOut()).called(1);
      });
    });

    group('google', () {
      test('successfully', () async {
        when(googleSignIn.signOut()).thenAnswer((_) => Future.value());

        try {
          await signOutService.google();
        } catch (e) {
          fail('Did not pass as expected');
        }

        verify(googleSignIn.signOut()).called(1);
      });

      test('throws SignOutException', () async {
        when(googleSignIn.signOut()).thenThrow(Exception());

        try {
          await signOutService.google();
          fail('Did not throw as expected');
        } catch (e) {
          expect(e, isA<SignOutException>());
        }

        verify(googleSignIn.signOut()).called(1);
      });

      test('throws MissingDependencyException', () async {
        try {
          await signOutServiceWithoutGoogle.google();
          fail('Did not throw as expected');
        } catch (e) {
          expect(e, isA<MissingDependencyException>());
        }
      });
    });
  });
}
