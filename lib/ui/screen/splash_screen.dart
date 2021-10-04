import 'package:auth_module/constants/app_constants.dart';
import 'package:auth_module/ui/screen/login_screen.dart';
import 'package:auth_module/ui/screen/main_screen.dart';
import 'package:auth_module/utils/preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _prefenceHelper = PreferenceHelper(SharedPreferences.getInstance());
  @override
  void initState() {
    super.initState();
    _checkUSerSession();
  }

  _checkUSerSession() async {
    String id = await _prefenceHelper.id;
    if (id.isNotEmpty) {
      Get.off(() => const MainScreen());
    } else {
      Get.off(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Center(
        child: Text(
          "Splash Screen",
          style: primaryTextStyle.copyWith(fontSize: 25),
        ),
      ),
    );
  }
}
