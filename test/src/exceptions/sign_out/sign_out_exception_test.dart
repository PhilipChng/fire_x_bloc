import 'package:flutter_test/flutter_test.dart';

import 'package:fire_x_bloc/fire_x_bloc.dart';

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
