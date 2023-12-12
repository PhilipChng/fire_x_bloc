// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:auth_repo/auth_repo.dart';
import 'sign_in_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<GoogleSignIn>(),
  MockSpec<GoogleSignInAccount>(),
  MockSpec<GoogleSignInAuthentication>(),
  MockSpec<UserCredential>(),
])
void main() {
  group('SignInService', () {
    final firebaseAuth = MockFirebaseAuth();
    final googleSignIn = MockGoogleSignIn();
    final mockGoogleUser = MockGoogleSignInAccount();
    final mockGoogleAuth = MockGoogleSignInAuthentication();
    final mockUserCredential = MockUserCredential();
    final signInService = SignInService(
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
    );
    final signInServiceWithoutGoogle = SignInService(
      firebaseAuth: firebaseAuth,
    );

    group('email and password', () {
      test(
        'sign in successfully',
        () async {
          when(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenAnswer((_) => Future.value(mockUserCredential));

          try {
            final userCred = await signInService.emailAndPassword(
              email: 'email',
              password: 'password',
            );
            expect(userCred, isA<UserCredential>());
          } catch (e) {
            fail('Did not pass as expected');
          }

          verify(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).called(1);
        },
      );

      test(
        'throws SignInWithEmailAndPasswordException on catching FirebaseAuthException',
        () async {
          when(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenThrow(FirebaseAuthException(code: 'code'));

          try {
            await signInService.emailAndPassword(
              email: 'email',
              password: 'password',
            );
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignInWithEmailAndPasswordException>());
            final error = e as SignInWithEmailAndPasswordException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).called(1);
        },
      );

      test(
        'throws SignInWithEmailAndPasswordException on catching other exceptions',
        () async {
          when(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenThrow(Exception());

          try {
            await signInService.emailAndPassword(
              email: 'email',
              password: 'password',
            );
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignInWithEmailAndPasswordException>());
            final error = e as SignInWithEmailAndPasswordException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).called(1);
        },
      );
    });

    group('google', () {
      test(
        'sign in successfully',
        () async {
          when(mockGoogleAuth.idToken).thenReturn('mockIdToken');
          when(mockGoogleAuth.accessToken).thenReturn('mockAccessToken');
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value(mockGoogleUser));
          when(
            mockGoogleUser.authentication,
          ).thenAnswer((_) => Future.value(mockGoogleAuth));
          when(
            firebaseAuth.signInWithCredential(any),
          ).thenAnswer((_) => Future.value(mockUserCredential));

          try {
            final userCred = await signInService.google();
            expect(userCred, isA<UserCredential>());
          } catch (e) {
            fail('Did not pass as expected');
          }

          verify(googleSignIn.signIn()).called(1);
          verify(mockGoogleUser.authentication).called(1);
          verify(firebaseAuth.signInWithCredential(any)).called(1);
        },
      );

      test(
        'throws FirebaseAuthException when google user is null',
        () async {
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value());

          try {
            await signInService.google();
            fail('should throw FirebaseAuthException');
          } catch (e) {
            expect(e, isA<SignInWithGoogleException>());
            final error = e as SignInWithGoogleException;
            expect(error.message, 'User has cancelled the action.');
          }

          verify(googleSignIn.signIn()).called(1);
          verifyNever(mockGoogleUser.authentication);
          verifyNever(firebaseAuth.signInWithCredential(any));
        },
      );

      test(
        'throws SignInWithGoogleException on catching FirebaseAuthException',
        () async {
          when(mockGoogleAuth.idToken).thenReturn('mockIdToken');
          when(mockGoogleAuth.accessToken).thenReturn('mockAccessToken');
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value(mockGoogleUser));
          when(
            mockGoogleUser.authentication,
          ).thenAnswer((_) => Future.value(mockGoogleAuth));
          when(
            firebaseAuth.signInWithCredential(any),
          ).thenThrow(FirebaseAuthException(code: 'code'));

          try {
            await signInService.google();
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignInWithGoogleException>());
            final error = e as SignInWithGoogleException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(googleSignIn.signIn()).called(1);
          verify(mockGoogleUser.authentication).called(1);
          verify(firebaseAuth.signInWithCredential(any)).called(1);
        },
      );

      test(
        'throws SignInWithGoogleException on catching other exceptions',
        () async {
          when(mockGoogleAuth.idToken).thenReturn('mockIdToken');
          when(mockGoogleAuth.accessToken).thenReturn('mockAccessToken');
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value(mockGoogleUser));
          when(
            mockGoogleUser.authentication,
          ).thenAnswer((_) => Future.value(mockGoogleAuth));
          when(
            firebaseAuth.signInWithCredential(any),
          ).thenThrow(Exception());

          try {
            await signInService.google();
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignInWithGoogleException>());
            final error = e as SignInWithGoogleException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(googleSignIn.signIn()).called(1);
          verify(mockGoogleUser.authentication).called(1);
          verify(firebaseAuth.signInWithCredential(any)).called(1);
        },
      );

      test(
        'throws MissingDependenciesException.googleSignIn()',
        () {
          expect(
            signInServiceWithoutGoogle.google,
            throwsA(isA<MissingDependencyException>()),
          );
        },
      );
    });

    group('anonymous', () {
      test(
        'sign in successfully',
        () async {
          when(
            firebaseAuth.signInAnonymously(),
          ).thenAnswer((_) => Future.value(mockUserCredential));

          try {
            final userCred = await signInService.anonymous();
            expect(userCred, isA<UserCredential>());
          } catch (e) {
            fail('Did not pass as expected');
          }

          verify(firebaseAuth.signInAnonymously()).called(1);
        },
      );

      test(
        'throws SignInAnonymouslyException on catching FirebaseAuthException',
        () async {
          when(
            firebaseAuth.signInAnonymously(),
          ).thenThrow(FirebaseAuthException(code: 'code'));

          try {
            await signInService.anonymous();
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignInAnonymouslyException>());
            final error = e as SignInAnonymouslyException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(firebaseAuth.signInAnonymously()).called(1);
        },
      );

      test(
        'throws SignInAnonymouslyException on catching other exceptions',
        () async {
          when(
            firebaseAuth.signInAnonymously(),
          ).thenThrow(Exception());

          try {
            await signInService.anonymous();
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignInAnonymouslyException>());
            final error = e as SignInAnonymouslyException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(firebaseAuth.signInAnonymously()).called(1);
        },
      );
    });
  });
}
