import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingAuthState extends AuthState {
  const LoadingAuthState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SuccessAuthRecovery extends AuthState {
  final int _ = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [_];
}

class ErrorLoginAuthState extends AuthState {
  final ErrorEntity errorEntity;

  const ErrorLoginAuthState(this.errorEntity);

  @override
  List<Object?> get props => [Exception];
}

class LoggedAuthState extends AuthState {
  final UserEntity user;

  const LoggedAuthState(this.user);

  @override
  List<Object?> get props => [user];
}
