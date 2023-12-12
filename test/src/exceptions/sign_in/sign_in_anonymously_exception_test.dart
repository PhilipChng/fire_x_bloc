import 'package:flutter_test/flutter_test.dart';

import 'package:auth_repo/auth_repo.dart';

void main() {
  group('SignInAnonymouslyException Tests', () {
    test(
      'should return the default message',
      () => expect(
        '${const SignInAnonymouslyException()}',
        'An unknown exception occurred.',
      ),
    );

    test(
      'should return correct message for operation-not-allowed',
      () => expect(
        '${SignInAnonymouslyException.fromCode('operation-not-allowed')}',
        'Operation is not allowed.  Please contact support.',
      ),
    );
  });
}
