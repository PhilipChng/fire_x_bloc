import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

/// {@template authentication_bloc}
/// Authentication bloc
/// {@endtemplate}
class AuthenticationBloc extends Cubit<AuthenticationState> {
  /// {@macro authentication_bloc}
  AuthenticationBloc({
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(
          auth.currentUser == null
              ? const Unauthenticated()
              : Authenticated(auth.currentUser!),
        ) {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        emit(const Unauthenticated());
      } else {
        emit(Authenticated(user));
      }
    });
  }

  final FirebaseAuth _auth;
}
