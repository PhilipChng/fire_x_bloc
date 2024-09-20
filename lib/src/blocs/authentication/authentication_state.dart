part of 'authentication_bloc.dart';

/// {@template authentication_state}
/// Authentication state
/// {@endtemplate}
sealed class AuthenticationState extends Equatable {
  /// {@macro authentication_state}
  const AuthenticationState({this.user});

  /// Firebase User
  final User? user;

  @override
  List<Object?> get props => [user];
}

/// {@template unauthenticated}
/// Unauthenticated state.
/// {@endtemplate}
class Unauthenticated extends AuthenticationState {
  /// {@macro unauthenticated}
  const Unauthenticated();
}

/// {@template authenticated}
/// Authenticated state.
/// {@endtemplate}
final class Authenticated extends AuthenticationState {
  /// {@macro authenticated}
  const Authenticated(User user) : super(user: user);
}
