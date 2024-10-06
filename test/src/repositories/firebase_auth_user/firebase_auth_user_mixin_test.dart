import 'package:fire_x_bloc/fire_x_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass with FirebaseAuthUserMixin {
  TestClass({FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  FirebaseAuth get firebaseAuth => _auth;
}

void main() {
  group('FirebaseAuthUserMixin', () {
    late MockFirebaseAuth auth;
    late MockUser mockUser;
    late TestClass testClass;

    setUp(() {
      mockUser = MockUser(
        uid: 'someuid',
        email: 'bob@somedomain.com',
        displayName: 'Bob',
      );
      auth = MockFirebaseAuth(
        signedIn: true,
        mockUser: mockUser,
      );
      testClass = TestClass(firebaseAuth: auth);
    });

    test('firebaseAuth getter returns injected FirebaseAuth instance', () {
      expect(testClass.firebaseAuth, equals(auth));
    });

    test('withFirebaseUser returns action result when user is not null',
        () async {
      final result = await testClass.withFirebaseUser(
        action: (user) async {
          expect(user, mockUser);
          return 'result';
        },
      );
      expect(result, 'result');
    });

    test('withFirebaseUser returns null when user is null', () async {
      await auth.signOut();
      final result = await testClass.withFirebaseUser(
        action: (user) async {
          fail('Action should not be called when user is null');
        },
      );
      expect(result, null);
    });

    test('withFirebaseUser propagates exception from action', () async {
      final exception = Exception('Test exception');
      expect(
        () async => testClass.withFirebaseUser(
          action: (user) async {
            throw exception;
          },
        ),
        throwsA(exception),
      );
    });
  });
}
