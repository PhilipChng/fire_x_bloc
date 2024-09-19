import 'package:flutter_test/flutter_test.dart';

import 'package:fire_x_bloc/fire_x_bloc.dart';

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
