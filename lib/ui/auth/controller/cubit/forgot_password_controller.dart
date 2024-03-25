import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/auth/controller/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());
  final AuthService _authService = AuthService.instance;

  Future<void> sendEmail(String email) async {
    emit(const LoadingForgotPasswordState());
    await _authService.resetPassword(email);
    emit(ForgotPasswordSendState());
  }
}
