import 'package:flutter_test/flutter_test.dart';

import 'package:auth_repo/auth_repo.dart';

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
