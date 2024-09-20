import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:fire_x_bloc/fire_x_bloc.dart';
import 'authentication_state_test.mocks.dart';

@GenerateNiceMocks([MockSpec<User>()])
void main() {
  group('AuthenticationState', () {
    late MockUser user;
    late Unauthenticated unauthenticated;
    late Authenticated authenticated;

    setUp(() {
      user = MockUser();
      unauthenticated = const Unauthenticated();
      authenticated = Authenticated(user);
    });

    group('Unauthenticated', () {
      test('is a subclass of AuthenticationState', () {
        expect(unauthenticated, isA<AuthenticationState>());
      });

      test('props is empty', () {
        expect(unauthenticated.props, isNotEmpty);
        expect(unauthenticated.props.first, isNull);
      });

      test('is Equatable', () {
        expect(unauthenticated == const Unauthenticated(), isTrue);
      });
    });

    group('Authenticated', () {
      test('is a subclass of AuthenticationState', () {
        expect(authenticated, isA<AuthenticationState>());
      });

      test('props is not empty and has user', () {
        expect(authenticated.props, isNotEmpty);
        expect(authenticated.props.first, user);
      });

      test('is Equatable', () {
        expect(authenticated == Authenticated(user), isTrue);
      });
    });
  });
}
