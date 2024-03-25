import 'package:flutter/material.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? currentWidget;
  Permission? currentTitle;

  @override
  void initState() {
    currentWidget = Container();
    currentTitle = Permission.dashboard;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: SizedBox(
            height: 30,
            child: AppLogo.horizontal(),
          ),
        ),
        drawer: AppDrawer(
          onChange: _changeView,
          currentSelected: currentTitle,
        ),
        body: AppBody(
          title: currentTitle?.name ?? '',
          child: currentWidget,
        ),
      ),
    );
  }

  void _changeView(Widget widget, Permission title) {
    currentTitle = title;
    currentWidget = widget;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      setState(() {});
    });
  }
}
