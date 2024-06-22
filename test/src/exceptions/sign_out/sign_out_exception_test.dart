import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth_bloc/firebase_auth_bloc.dart';

void main() {
  group('SignOutException Tests', () {
    test(
      'should return the default message',
      () => expect(
        '${const SignOutException()}',
        'Failed to sign out.',
      ),
    );
  });
}
