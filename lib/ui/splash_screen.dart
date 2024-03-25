import 'package:flutter/material.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/auth/route.dart';
import 'package:rg_track/ui/dashboard/route.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/go_route_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthService.instance.getUser(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Future.microtask(() {
              if (snapshot.hasData) {
                if (snapshot.data!.authorized) {
                  routeDashboard.go(context);
                } else {
                  routeSignIn.go(context);
                }
              } else {
                routeSignIn.go(context);
              }
            });
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: AppLogo()),
          );
        },
      ),
    );
  }
}
