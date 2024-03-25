import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/users/child/single/user_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class ShowUserScreen extends StatefulWidget {
  final UserEntity user;
  final String id;

  const ShowUserScreen({
    super.key,
    required this.user,
    required this.id,
  });

  @override
  State<ShowUserScreen> createState() => _ShowUserScreenState();
}

class _ShowUserScreenState extends State<ShowUserScreen> {
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
        title: 'Visualizar Usuário',
        maxWidth: true,
        child: UserForm(
          user: widget.user,
          formOption: EnumFormOption.VIEW,
        ),
      ),
    );
  }
}
