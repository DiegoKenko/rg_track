import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/ui/auth/controller/auth_controller.dart';
import 'package:rg_track/ui/auth/controller/cubit/forgot_password_controller.dart';
import 'package:rg_track/ui/auth/controller/cubit/forgot_password_state.dart';
import 'package:rg_track/ui/auth/route.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/go_route_extension.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _loginController = TextEditingController();

  final FocusNode _loginFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          builder: (context, state) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            margin:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  AppLogo(),
                  const SizedBox(height: 47),
                  Text(
                    'Insira abaixo o seu email cadastrado para recuperar o acesso.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    autofocus: true,
                    focusNode: _loginFocus,
                    controller: _loginController,
                    decoration: const InputDecoration(hintText: 'Email '),
                    onSaved: (String? newValue) {
                      if (newValue != null) {
                        getIt<AuthController>().forgotPassword(newValue);
                      }
                    },
                    onFieldSubmitted: _saveForm,
                    validator: (String? value) {
                      if (value == null) return null;
                      if (value.isEmpty) {
                        return 'Você precisar se identificar para continuar';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  state is ForgotPasswordSendState
                      ? ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: () {
                            routeSignIn.go(context);
                          },
                          child: const Center(
                            child: Text(
                              'redefinição de senha enviado para o email',
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                      : ElevatedButton(
                          onPressed: () {
                            if (state is! ForgotPasswordSendState) {
                              _saveForm();
                            }
                          },
                          child: Center(
                            child: Text(
                              'Solicitar redefinição de senha'.toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          routeSignIn.go(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Voltar'.toUpperCase(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _saveForm([String? value]) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<ForgotPasswordCubit>().sendEmail(_loginController.text);
    } else {
      if (!_loginFocus.hasFocus && _loginFocus.context != null) {
        FocusScope.of(_loginFocus.context!).requestFocus(_loginFocus);
      }
    }
  }
}
