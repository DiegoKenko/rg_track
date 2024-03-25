import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/ui/auth/controller/cubit/forgot_password_controller.dart';
import 'package:rg_track/ui/auth/forgot_password_screen.dart';
import 'package:rg_track/ui/auth/sign_in_screen.dart';

final GoRoute routeSignIn = GoRoute(
  name: 'Entrar',
  path: '/conta/entrar',
  builder: (BuildContext context, GoRouterState state) {
    return const SignInScreen();
  },
);

final GoRoute routeForgotPassword = GoRoute(
  name: 'Esqueci minha senha',
  path: '/conta/esqueceu-a-senha',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForgotPasswordCubit>(
            create: (BuildContext context) => ForgotPasswordCubit()),
      ],
      child: const ForgotPasswordScreen(),
    );
  },
);
