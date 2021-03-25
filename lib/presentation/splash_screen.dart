import 'package:flutter/material.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();

    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.pushReplacementNamed(context, AppNavigation.authRouteName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Center(
                child: Image.asset(
              "assets/launcher/droply.png",
              height: 200,
              width: 200,
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/launcher/sudox.jpg",
                      height: 70,
                      width: 70,
                    ),
                    const Text(
                      "SUDOX",
                      style: TextStyle(
                        color: AppColors.lightenHintTextColor,
                        fontFamily: AppFonts.openSans,
                        fontWeight: AppFonts.semibold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
