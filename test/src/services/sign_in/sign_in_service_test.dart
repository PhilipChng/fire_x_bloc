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
    late MockFirebaseAuth firebaseAuth;
    late MockGoogleSignIn googleSignIn;
    late MockGoogleSignInAccount googleUser;
    late MockGoogleSignInAuthentication googleAuth;
    late MockUserCredential userCredential;
    late SignInService signInService;
    late SignInService signInServiceWithoutGoogle;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      googleUser = MockGoogleSignInAccount();
      googleAuth = MockGoogleSignInAuthentication();
      userCredential = MockUserCredential();
      signInService = SignInService(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      );
      signInServiceWithoutGoogle = SignInService(
        firebaseAuth: firebaseAuth,
      );
    });

    group('email and password', () {
      test(
        'sign in successfully',
        () async {
          when(
            firebaseAuth.signInWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenAnswer((_) => Future.value(userCredential));

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

    group('email link', () {
      late String email;
      late ActionCodeSettings acs;

      setUp(() {
        email = 'testing_email@developer.com';
        acs = ActionCodeSettings(
          url: 'acsURL',
          handleCodeInApp: true,
          iOSBundleId: 'iOSBundleId',
          androidPackageName: 'androidPackageName',
          androidInstallApp: true,
        );
      });

      group('send', () {
        test(
          'successfully',
          () async {
            when(
              firebaseAuth.sendSignInLinkToEmail(
                email: email,
                actionCodeSettings: acs,
              ),
            ).thenAnswer((_) => Future.value());

            try {
              await signInService.sendEmailLink(email: email, acs: acs);
            } catch (e) {
              fail('Did not pass as expected');
            }

            verify(
              firebaseAuth.sendSignInLinkToEmail(
                email: email,
                actionCodeSettings: acs,
              ),
            ).called(1);
          },
        );

        test(
          'throws SignInWithEmailLinkException on catching FirebaseAuthException',
          () async {
            when(
              firebaseAuth.sendSignInLinkToEmail(
                email: email,
                actionCodeSettings: acs,
              ),
            ).thenThrow(FirebaseAuthException(code: 'code'));

            try {
              await signInService.sendEmailLink(email: email, acs: acs);
              fail('Did not throw as expected');
            } catch (e) {
              expect(e, isA<SignInWithEmailLinkException>());
              final error = e as SignInWithEmailLinkException;
              expect(error.message, 'An unknown exception occurred.');
            }
          },
        );

        test(
          'throws SignInWithEmailLinkException on catching other exceptions',
          () async {
            when(
              firebaseAuth.sendSignInLinkToEmail(
                email: email,
                actionCodeSettings: acs,
              ),
            ).thenThrow(Exception());

            try {
              await signInService.sendEmailLink(email: email, acs: acs);
              fail('Did not throw as expected');
            } catch (e) {
              expect(e, isA<SignInWithEmailLinkException>());
              final error = e as SignInWithEmailLinkException;
              expect(error.message, 'An unknown exception occurred.');
            }
          },
        );
      });

      group('verify', () {
        late String email;
        late String emailLink;

        setUp(() {
          email = 'testing_email@developer.com';
          emailLink = 'emailLink';
        });

        test(
          'successfully',
          () async {
            when(
              firebaseAuth.isSignInWithEmailLink(emailLink),
            ).thenAnswer((_) => true);

            when(
              firebaseAuth.signInWithEmailLink(
                email: email,
                emailLink: emailLink,
              ),
            ).thenAnswer((_) => Future.value(userCredential));

            try {
              final userCred = await signInService.verifyEmailLink(
                email: email,
                emailLink: emailLink,
              );
              expect(userCred, isA<UserCredential>());
            } catch (e) {
              fail('Did not pass as expected');
            }
          },
        );

        test(
          'throws SignInWithEmailLinkException on catching FirebaseAuthException',
          () async {
            when(
              firebaseAuth.isSignInWithEmailLink(emailLink),
            ).thenAnswer((_) => true);

            when(
              firebaseAuth.signInWithEmailLink(
                email: email,
                emailLink: emailLink,
              ),
            ).thenThrow(FirebaseAuthException(code: 'code'));

            try {
              await signInService.verifyEmailLink(
                email: email,
                emailLink: emailLink,
              );
              fail('Did not throw as expected');
            } catch (e) {
              expect(e, isA<SignInWithEmailLinkException>());
              final error = e as SignInWithEmailLinkException;
              expect(error.message, 'An unknown exception occurred.');
            }
          },
        );

        test(
          'throws SignInWithEmailLinkException on catching other exceptions',
          () async {
            when(
              firebaseAuth.isSignInWithEmailLink(emailLink),
            ).thenAnswer((_) => true);

            when(
              firebaseAuth.signInWithEmailLink(
                email: email,
                emailLink: emailLink,
              ),
            ).thenThrow(Exception());

            try {
              await signInService.verifyEmailLink(
                email: email,
                emailLink: emailLink,
              );
              fail('Did not throw as expected');
            } catch (e) {
              expect(e, isA<SignInWithEmailLinkException>());
              final error = e as SignInWithEmailLinkException;
              expect(error.message, 'An unknown exception occurred.');
            }
          },
        );

        test(
          'throws SignInWithEmailLinkException on invalid email link',
          () async {
            when(
              firebaseAuth.isSignInWithEmailLink(emailLink),
            ).thenAnswer((_) => false);

            try {
              await signInService.verifyEmailLink(
                email: email,
                emailLink: emailLink,
              );
              fail('Did not throw as expected');
            } catch (e) {
              expect(e, isA<SignInWithEmailLinkException>());
              final error = e as SignInWithEmailLinkException;
              expect(error.message, 'An unknown exception occurred.');
            }
          },
        );
      });
    });

    group('google', () {
      test(
        'sign in successfully',
        () async {
          when(googleAuth.idToken).thenReturn('mockIdToken');
          when(googleAuth.accessToken).thenReturn('mockAccessToken');
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value(googleUser));
          when(
            googleUser.authentication,
          ).thenAnswer((_) => Future.value(googleAuth));
          when(
            firebaseAuth.signInWithCredential(any),
          ).thenAnswer((_) => Future.value(userCredential));

          try {
            final userCred = await signInService.google();
            expect(userCred, isA<UserCredential>());
          } catch (e) {
            fail('Did not pass as expected');
          }

          verify(googleSignIn.signIn()).called(1);
          verify(googleUser.authentication).called(1);
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
          verifyNever(googleUser.authentication);
          verifyNever(firebaseAuth.signInWithCredential(any));
        },
      );

      test(
        'throws SignInWithGoogleException on catching FirebaseAuthException',
        () async {
          when(googleAuth.idToken).thenReturn('mockIdToken');
          when(googleAuth.accessToken).thenReturn('mockAccessToken');
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value(googleUser));
          when(
            googleUser.authentication,
          ).thenAnswer((_) => Future.value(googleAuth));
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
          verify(googleUser.authentication).called(1);
          verify(firebaseAuth.signInWithCredential(any)).called(1);
        },
      );

      test(
        'throws SignInWithGoogleException on catching other exceptions',
        () async {
          when(googleAuth.idToken).thenReturn('mockIdToken');
          when(googleAuth.accessToken).thenReturn('mockAccessToken');
          when(
            googleSignIn.signIn(),
          ).thenAnswer((_) => Future.value(googleUser));
          when(
            googleUser.authentication,
          ).thenAnswer((_) => Future.value(googleAuth));
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
          verify(googleUser.authentication).called(1);
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
          ).thenAnswer((_) => Future.value(userCredential));

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
