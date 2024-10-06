// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';

/// A mixin that provides a utility method to perform an action with the
/// current authenticated Firebase [User], if one exists.
mixin FirebaseAuthUserMixin {
  /// Provides access to the [FirebaseAuth] instance.
  ///
  /// By default, this getter returns [FirebaseAuth.instance], but it can be
  /// overridden in subclasses or during testing to inject a different instance
  /// of [FirebaseAuth].
  FirebaseAuth get firebaseAuth;

  /// Executes the provided asynchronous [action] with the current
  /// authenticated [User] from Firebase Authentication.
  ///
  /// If a user is currently signed in (`FirebaseAuth.instance.currentUser` is not null),
  /// this method calls the [action] with that user. Otherwise, it returns `null`.
  ///
  /// The [action] parameter is a required function that accepts a [User] and
  /// returns a `Future<T>`. The generic type `T` allows flexibility in the
  /// return type based on your specific use case.
  ///
  /// Returns a `Future<T?>` that completes with the result of [action], or
  /// `null` if there is no authenticated user.
  ///
  /// #### Example:
  ///
  /// ```dart
  /// class MyService with FirebaseAuthUserMixin {
  ///   Future<String?> fetchUserData() async {
  ///     return await withFirebaseUser(action: (user) async {
  ///       // Perform some operations with the user
  ///       return 'User data for ${user.uid}';
  ///     });
  ///   }
  /// }
  /// ```
  ///
  /// In the example above, if a user is signed in, `fetchUserData` will
  /// return the user data string. If no user is signed in, it will return `null`.
  ///
  /// #### Errors:
  ///
  /// Any exceptions thrown within the [action] will propagate through this
  /// method. Ensure proper error handling when using [withFirebaseUser].
  Future<T?> withFirebaseUser<T>({
    required Future<T> Function(User) action,
  }) async {
    final user = firebaseAuth.currentUser;
    return user != null ? action(user) : null;
  }
}
