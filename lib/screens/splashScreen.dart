import 'package:flutter/material.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen/login_screen.dart';
import 'dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    CheckLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.today)),
    );
  }


  // ---------- check user login status --------------
  void CheckLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    String? isLogin = await prefs.getString(Session().isLogin);

    isLogin == "true"
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashBoardScreen(),
            ))
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
  }
}
