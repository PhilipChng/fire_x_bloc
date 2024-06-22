import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth_bloc/firebase_auth_bloc.dart';

void main() {
  group('MissingDependenciesException Tests', () {
    test(
      'should return correct message for GoogleSignIn dependency',
      () {
        expect(
          '${MissingDependencyException.googleSignIn()}',
          'Missing dependency: GoogleSignIn ',
        );
      },
    );
  });
}
