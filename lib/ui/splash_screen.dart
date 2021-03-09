import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/values/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
// commit from dev
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this, value: 0.2);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceIn);

    _controller.forward();
    Future.delayed(Duration(milliseconds: 2800)).then((value) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      if (_auth.currentUser == null) {
        ExtendedNavigator.of(context).popAndPush(Routes.loginPage);
      } else {
        ExtendedNavigator.of(context).popAndPush(Routes.homePage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.MAIN_COLOR,
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ScaleTransition(
                    scale: _animation,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Image.asset(
                          "assets/images/ic_logo_white.png",
                          width: 200,
                          height: 200,
                        ),
                        Container(
                          height: 20,
                        ),
                        Text(
                          "Project Manager",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.TEXT_WHITE),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
                  child: Text("Powered by Horizon Pvt Ltd", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: AppColors.TEXT_WHITE),),
                )
              ],
            ),
          ),
        ));
  }
}
