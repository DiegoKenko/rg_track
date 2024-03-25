import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/users/child/single/user_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class StoreUserScreen extends StatelessWidget {
  const StoreUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      body: AppBody(
        title: 'Novo Usuário',
        maxWidth: true,
        child: UserForm(
          user: UserEntity.commom(parentId: AuthService.instance.user.id ?? ''),
          formOption: EnumFormOption.CREATE,
        ),
      ),
    );
  }
}
