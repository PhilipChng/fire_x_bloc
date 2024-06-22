// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_authentication_bloc/firebase_authentication_bloc.dart';

void main() {
  group('SignInWithGoogleException Tests', () {
    test(
      'should return the default message',
      () => expect(
        '${const SignInWithGoogleException()}',
        'An unknown exception occurred.',
      ),
    );

    test(
      'should return correct message for account-exists-with-different-credential',
      () => expect(
        '${SignInWithGoogleException.fromCode('account-exists-with-different-credential')}',
        'Account exists with different credentials.',
      ),
    );

    test(
      'should return correct message for invalid-credential',
      () => expect(
        '${SignInWithGoogleException.fromCode('invalid-credential')}',
        'The credential received is malformed or has expired.',
      ),
    );

    test(
      'should return correct message for operation-not-allowed',
      () => expect(
        '${SignInWithGoogleException.fromCode('operation-not-allowed')}',
        'Operation is not allowed.  Please contact support.',
      ),
    );

    test(
      'should return correct message for user-disabled',
      () => expect(
        '${SignInWithGoogleException.fromCode('user-disabled')}',
        'This user has been disabled. Please contact support for help.',
      ),
    );

    test(
      'should return correct message for user-not-found',
      () => expect(
        '${SignInWithGoogleException.fromCode('user-not-found')}',
        'Email is not found, please create an account.',
      ),
    );

    test(
      'should return correct message for wrong-password',
      () => expect(
        '${SignInWithGoogleException.fromCode('wrong-password')}',
        'Incorrect password, please try again.',
      ),
    );

    test(
      'should return correct message for invalid-verification-code',
      () => expect(
        '${SignInWithGoogleException.fromCode('invalid-verification-code')}',
        'The credential verification code received is invalid.',
      ),
    );

    test(
      'should return correct message for invalid-verification-id',
      () => expect(
        '${SignInWithGoogleException.fromCode('invalid-verification-id')}',
        'The credential verification ID received is invalid.',
      ),
    );

    test(
      'should return correct message for user-cancelled',
      () => expect(
        '${SignInWithGoogleException.fromCode('user-cancelled')}',
        'User has cancelled the action.',
      ),
    );
  });
}
