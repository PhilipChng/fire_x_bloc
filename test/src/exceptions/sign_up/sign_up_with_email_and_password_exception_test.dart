// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';

import 'package:fire_x_bloc/fire_x_bloc.dart';

void main() {
  group('SignUpWithEmailAndPasswordException Tests', () {
    test(
      'should return the default message',
      () => expect(
        '${const SignUpWithEmailAndPasswordException()}',
        'An unknown exception occurred.',
      ),
    );

    test(
      'should return correct message for invalid-email',
      () => expect(
        '${SignUpWithEmailAndPasswordException.fromCode('invalid-email')}',
        'Email is not valid or badly formatted.',
      ),
    );

    test(
      'should return correct message for user-disabled',
      () => expect(
        '${SignUpWithEmailAndPasswordException.fromCode('user-disabled')}',
        'This user has been disabled. Please contact support for help.',
      ),
    );

    test(
      'should return correct message for email-already-in-use',
      () => expect(
        '${SignUpWithEmailAndPasswordException.fromCode('email-already-in-use')}',
        'An account already exists for that email.',
      ),
    );

    test(
      'should return correct message for operation-not-allowed',
      () => expect(
        '${SignUpWithEmailAndPasswordException.fromCode('operation-not-allowed')}',
        'Operation is not allowed.  Please contact support.',
      ),
    );

    test(
      'should return correct message for weak-password',
      () => expect(
        '${SignUpWithEmailAndPasswordException.fromCode('weak-password')}',
        'Please enter a stronger password.',
      ),
    );
  });
}
