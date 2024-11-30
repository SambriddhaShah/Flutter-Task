import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipstick/Routes/routes.dart';
import 'package:lipstick/Routes/routesGenerator.dart';
import 'package:lipstick/utils/customColors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);


    Future.delayed(const Duration(seconds: 2), () async {
    
      Navigator.of(context).pushReplacement(RouteGenerator()
          .generateRoute(const RouteSettings(name: Routes.prouctDetails)));
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.appColor,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: CustomColors.appColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/icon.png")],
          ),
        ));
  }
}
