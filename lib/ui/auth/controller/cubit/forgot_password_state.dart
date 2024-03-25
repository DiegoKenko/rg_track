import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitialState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class LoadingForgotPasswordState extends ForgotPasswordState {
  const LoadingForgotPasswordState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ForgotPasswordSendState extends ForgotPasswordState {
  final int _ = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [_];
}

class ErrorForgotPasswordState extends ForgotPasswordState {
  final ErrorEntity errorEntity;

  const ErrorForgotPasswordState(this.errorEntity);

  @override
  List<Object?> get props => [Exception];
}
