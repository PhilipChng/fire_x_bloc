// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth_bloc/firebase_auth_bloc.dart';

void main() {
  group('SignInWithEmailLinkException Tests', () {
    test(
      'should return the default message',
      () => expect(
        '${const SignInWithEmailLinkException()}',
        'An unknown exception occurred.',
      ),
    );

    test(
      'should return correct message for expired-action-code',
      () => expect(
        '${SignInWithEmailLinkException.fromCode('expired-action-code')}',
        'The action code has expired. Please resend the verification code to try again.',
      ),
    );

    test(
      'should return correct message for invalid-email',
      () => expect(
        '${SignInWithEmailLinkException.fromCode('invalid-email')}',
        'Email is not valid or badly formatted.',
      ),
    );

    test(
      'should return correct message for invalid-email-link',
      () => expect(
        '${SignInWithEmailLinkException.fromCode('invalid-email-link')}',
        'The link is not valid.',
      ),
    );

    test(
      'should return correct message for user-disabled',
      () => expect(
        '${SignInWithEmailLinkException.fromCode('user-disabled')}',
        'This user has been disabled. Please contact support for help.',
      ),
    );
  });
}
