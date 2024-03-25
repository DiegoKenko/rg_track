import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/users/child/single/user_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class UpdateUserScreen extends StatefulWidget {
  final UserEntity user;
  final String? id;

  const UpdateUserScreen({
    super.key,
    required this.user,
    this.id,
  });

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
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
        title: 'Atualizar Usuário',
        maxWidth: true,
        child: UserForm(
          user: widget.user,
          formOption: EnumFormOption.UPDATE,
        ),
      ),
    );
  }
}
