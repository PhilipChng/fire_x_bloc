// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:auth_repo/auth_repo.dart';
import 'sign_up_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
])
void main() {
  group('SignUpService', () {
    late MockFirebaseAuth firebaseAuth;
    late MockUserCredential userCredential;
    late SignUpService signUpService;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      userCredential = MockUserCredential();
      signUpService = SignUpService(
        firebaseAuth: firebaseAuth,
      );
    });

    group('email and password', () {
      test(
        'sign up successfully',
        () async {
          when(
            firebaseAuth.createUserWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenAnswer((_) => Future.value(userCredential));

          try {
            final userCred = await signUpService.emailAndPassword(
              email: 'email',
              password: 'password',
            );
            expect(userCred, isA<UserCredential>());
          } catch (e) {
            fail('Did not pass as expected');
          }

          verify(
            firebaseAuth.createUserWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).called(1);
        },
      );

      test(
        'throws SignUpWithEmailAndPasswordException on catching FirebaseAuthException',
        () async {
          when(
            firebaseAuth.createUserWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenThrow(FirebaseAuthException(code: 'code'));

          try {
            await signUpService.emailAndPassword(
              email: 'email',
              password: 'password',
            );
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignUpWithEmailAndPasswordException>());
            final error = e as SignUpWithEmailAndPasswordException;
            expect(error.message, 'An unknown exception occurred.');
          }

          verify(
            firebaseAuth.createUserWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).called(1);
        },
      );

      test(
        'throws SignUpWithEmailAndPasswordException on catching other exceptions',
        () async {
          when(
            firebaseAuth.createUserWithEmailAndPassword(
              email: 'email',
              password: 'password',
            ),
          ).thenThrow(Exception());

          try {
            await signUpService.emailAndPassword(
              email: 'email',
              password: 'password',
            );
            fail('Did not throw as expected');
          } catch (e) {
            expect(e, isA<SignUpWithEmailAndPasswordException>());
            final error = e as SignUpWithEmailAndPasswordException;
            expect(error.message, 'An unknown exception occurred.');
          }
        },
      );
    });
  });
}
