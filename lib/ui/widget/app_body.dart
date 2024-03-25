import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class AppBody extends StatelessWidget {
  final String title;
  final Widget? child;
  final bool maxWidth;
  final bool inherit;

  const AppBody({
    super.key,
    required this.title,
    this.child,
    this.inherit = false,
    this.maxWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: inherit
                  ? 0
                  : isWideScreen(context)
                      ? 60
                      : 50,
            ),
            constraints: maxWidth
                ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width)
                : null,
            child: child ??
                Center(
                    child: Message(
                  title: 'Em manutenção',
                  body:
                      'Ops! Estamos em manutenção.\nPor favor, tente novamente mais tarde.',
                  icon: MdiIcons.tools,
                )),
          ),
          isWideScreen(context)
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color(0xFFF0F0F0),
                    height: 25,
                    child: Center(
                      child: Text(
                          "Todos os direitos reservados RG TRACK © ${DateTime.now().year}"),
                    ),
                  ),
                )
              : Container(),
          Elevated(
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width *
                  context.onWideScreen(0.6, 0.9)!,
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 20,
                  left: context.onWideScreen(150, 16)!),
              margin: const EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              duration: const Duration(milliseconds: 250),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  title.toUpperCase(),
                  key: Key(title),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 2,
                      wordSpacing: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
