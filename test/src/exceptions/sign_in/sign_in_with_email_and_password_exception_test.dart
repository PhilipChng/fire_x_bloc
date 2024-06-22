// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_authentication_bloc/firebase_authentication_bloc.dart';

void main() {
  group('SignInWithEmailAndPasswordException Tests', () {
    test(
      'should return the default message',
      () => expect(
        '${const SignInWithEmailAndPasswordException()}',
        'An unknown exception occurred.',
      ),
    );

    test(
      'should return correct message for invalid-email',
      () => expect(
        '${SignInWithEmailAndPasswordException.fromCode('invalid-email')}',
        'Email is not valid or badly formatted.',
      ),
    );

    test(
      'should return correct message for user-disabled',
      () => expect(
        '${SignInWithEmailAndPasswordException.fromCode('user-disabled')}',
        'This user has been disabled. Please contact support for help.',
      ),
    );

    test(
      'should return correct message for user-not-found',
      () => expect(
        '${SignInWithEmailAndPasswordException.fromCode('user-not-found')}',
        'Email is not found, please create an account.',
      ),
    );

    test(
      'should return correct message for wrong-password',
      () => expect(
        '${SignInWithEmailAndPasswordException.fromCode('wrong-password')}',
        'Incorrect password, please try again.',
      ),
    );
  });
}
