import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:firebase_auth_bloc/firebase_auth_bloc.dart';
import 'firebase_authentication_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<GoogleSignIn>(),
  MockSpec<SignInService>(),
  MockSpec<SignOutService>(),
  MockSpec<SignUpService>(),
])
void main() {
  group('AuthRepo', () {
    late MockFirebaseAuth firebaseAuth;
    late MockGoogleSignIn googleSignIn;
    late MockSignInService signInService;
    late MockSignOutService signOutService;
    late MockSignUpService signUpService;
    late FirebaseAuthenticationRepository authRepo;
    late FirebaseAuthenticationRepository authRepoWithoutGoogle;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      signInService = MockSignInService();
      signOutService = MockSignOutService();
      signUpService = MockSignUpService();
      authRepo = FirebaseAuthenticationRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
        signInService: signInService,
        signOutService: signOutService,
        signUpService: signUpService,
      );
      authRepoWithoutGoogle = FirebaseAuthenticationRepository(
        firebaseAuth: firebaseAuth,
        signInService: signInService,
        signOutService: signOutService,
        signUpService: signUpService,
      );
    });

    test('creates services internally when not injected', () {
      expect(
        () => FirebaseAuthenticationRepository(firebaseAuth: firebaseAuth),
        isNot(throwsException),
      );
    });

    test('sign up with email and password', () async {
      try {
        await authRepo.signUpWithEmailAndPassword(
          'email',
          'password',
        );
      } catch (e) {
        fail('Did not pass as expected');
      }

      verify(
        signUpService.emailAndPassword(
          email: 'email',
          password: 'password',
        ),
      ).called(1);
    });

    test('sign in with email and password', () async {
      try {
        await authRepo.signInWithEmailAndPassword(
          'email',
          'password',
        );
      } catch (e) {
        fail('Did not pass as expected');
      }

      verify(
        signInService.emailAndPassword(
          email: 'email',
          password: 'password',
        ),
      ).called(1);
    });

    test('sign in with google', () async {
      try {
        await authRepo.signInWithGoogle();
      } catch (e) {
        fail('Did not pass as expected');
      }

      verify(signInService.google()).called(1);
    });

    test('sign in anonymously', () async {
      try {
        await authRepo.signInAnonymously();
      } catch (e) {
        fail('Did not pass as expected');
      }

      verify(signInService.anonymous()).called(1);
    });

    test('sign out', () async {
      try {
        await authRepo.signOut();
      } catch (e) {
        fail('Did not pass as expected');
      }

      verify(signOutService.firebase()).called(1);
      verify(signOutService.google()).called(1);
    });

    test('sign out without google', () async {
      try {
        await authRepoWithoutGoogle.signOut();
      } catch (e) {
        fail('Did not pass as expected');
      }

      verify(signOutService.firebase()).called(1);
    });
  });
}
