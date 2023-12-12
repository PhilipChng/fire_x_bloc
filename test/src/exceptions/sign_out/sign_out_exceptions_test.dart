import 'package:flutter_test/flutter_test.dart';

import 'package:auth_repo/auth_repo.dart';

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
