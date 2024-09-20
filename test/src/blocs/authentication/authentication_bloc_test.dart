import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fire_x_bloc/fire_x_bloc.dart';

void main() {
  group('AuthenticationBloc', () {
    late MockUser user;
    late MockFirebaseAuth auth;
    late AuthenticationBloc bloc;

    setUp(() {
      user = MockUser(uid: 'uid', email: 'mock@test.com');
      auth = MockFirebaseAuth();
      bloc = AuthenticationBloc(auth: auth);
    });

    group('initial state', () {
      test('is Unauthenticated when user is not signed in', () {
        expect(
          AuthenticationBloc(
            auth: MockFirebaseAuth(),
          ).state,
          const Unauthenticated(),
        );
      });

      test('is Authenticated when user is not signed in', () {
        expect(
          AuthenticationBloc(
            auth: MockFirebaseAuth(mockUser: user, signedIn: true),
          ).state,
          Authenticated(user),
        );
      });
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emit [Authenticated] when user is signed in',
      build: () => bloc,
      act: (bloc) {
        auth
          ..mockUser = user
          ..signInWithEmailAndPassword(
            email: 'mock@test.com',
            password: 'password',
          );
      },
      expect: () => [Authenticated(user)],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emit [Unauthenticated] when user is signed out',
      seed: () => Authenticated(user),
      build: () => bloc,
      act: (bloc) {
        auth.signOut();
      },
      expect: () => [const Unauthenticated()],
    );
  });
}
