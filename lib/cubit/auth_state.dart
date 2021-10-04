part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class UserLoaded extends AuthState {
  final User user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadingFailed extends AuthState {
  final String message;

  UserLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

//jika register tidak punya return value

class RegisterLoaded extends AuthState {
  final bool user;

  RegisterLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class RegisterFailed extends AuthState {
  final String message;

  RegisterFailed(this.message);

  @override
  List<Object> get props => [message];
}

class ForgotPassLoaded extends AuthState {
  final bool user;

  ForgotPassLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ForgotPassFailed extends AuthState {
  final String message;

  ForgotPassFailed(this.message);

  @override
  List<Object> get props => [message];
}
