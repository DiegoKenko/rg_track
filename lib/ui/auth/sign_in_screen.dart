import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/ui/auth/controller/auth_controller.dart';
import 'package:rg_track/ui/auth/controller/auth_state.dart';
import 'package:rg_track/ui/auth/route.dart';
import 'package:rg_track/ui/dashboard/route.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/go_route_extension.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();
  final FocusNode _loginFocus = FocusNode(), _passwordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final bool _loginOk = false;
  final AuthController _authController = getIt<AuthController>();
  final double width = 350;

  @override
  void initState() {
    _authController.addListener(() {
      if (_authController.value is LoggedAuthState) {
        routeDashboard.go(context);
      }
    });
    _authController.addListener(() {
      if (_authController.value is ErrorLoginAuthState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Falha ao fazer login. '),
              Text((_authController.value as ErrorLoginAuthState)
                  .errorEntity
                  .message),
            ],
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: width),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Form(
              key: _formKey,
              onWillPop: () async {
                return _loginOk;
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  AppLogo(),
                  const Divider(
                    color: Colors.transparent,
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      await _authController.loginGoogle();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.5,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Entrar com'.toUpperCase()),
                          const SizedBox(
                            width: 10,
                          ),
                          const Image(
                            image: AssetImage('assets/images/google.png'),
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.5,
                        width: width / 2 - 50,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? secondaryColor
                            : primaryColor,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Ou',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 0.5,
                        width: width / 2 - 50,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? secondaryColor
                            : primaryColor,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Usuário', hintText: 'E-mail'),
                    focusNode: _loginFocus,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (String? value) {
                      if (value == null) return null;
                      if (value.isEmpty) return 'Informe o usuário!';
                      if (value.length < 6) return 'Usuário inválido!';
                      return null;
                    },
                  ),
                  const Divider(color: Colors.transparent),
                  ValueListenableBuilder(
                      valueListenable: _authController.showPasswordNotifier,
                      builder: (context, state, _) {
                        return TextFormField(
                          controller: _passwordController,
                          maxLines: 1,
                          obscureText: true,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              suffixIcon: IconButton(
                                  onPressed: () => _authController
                                      .changePasswordVisibility(!state),
                                  icon: Icon((state)
                                      ? MdiIcons.eye
                                      : MdiIcons.eyeOff))),
                          focusNode: _passwordFocus,
                          onFieldSubmitted: (String value) {
                            _passwordFocus.unfocus();
                            _login();
                          },
                          validator: (String? value) {
                            if (value == null) return null;
                            if (value.isEmpty) return 'Informe a senha!';
                            if (value.length < 6) return 'Senha inválida!';
                            return null;
                          },
                        );
                      }),
                  const Divider(color: Colors.transparent),
                  ValueListenableBuilder(
                      valueListenable: _authController.logging,
                      builder: (context, state, _) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (!state) {
                              await _login();
                            }
                          },
                          child: Text(
                            state
                                ? 'Verificando credenciais..'
                                : 'Entrar'.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          routeForgotPassword.go(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Esqueci a senha'.toUpperCase(),
                            style: const TextStyle(fontSize: 13),
                          ),
                        )),
                  ),
                  ValueListenableBuilder<AuthState>(
                    valueListenable: _authController,
                    builder: (BuildContext context, state, _) {
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _authController.loginEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
  }
}
