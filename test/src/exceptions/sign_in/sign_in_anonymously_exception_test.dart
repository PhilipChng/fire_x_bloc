import 'package:flutter_test/flutter_test.dart';

import 'package:fire_x_bloc/fire_x_bloc.dart';

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
