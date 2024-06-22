import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_authentication_bloc/firebase_authentication_bloc.dart';

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
