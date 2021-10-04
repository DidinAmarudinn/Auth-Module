import 'package:auth_module/constants/app_constants.dart';
import 'package:auth_module/ui/components/custom_button.dart';
import 'package:auth_module/ui/screen/login_screen.dart';
import 'package:auth_module/utils/preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PreferenceHelper preferenceHelper =
      PreferenceHelper(SharedPreferences.getInstance());
  @override
  void initState() {
    super.initState();
    getUserid();
  }

  getUserid() async {
    String id = await preferenceHelper.id;
    String email = await preferenceHelper.email;
    String token = await preferenceHelper.token;

    print("id " + id);
    print("email " + email);
    print("token " + token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Center(
        child: CustomButtonWidget(
          buttonName: "Sign out",
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Get.offAll(() => LoginScreen());
          },
          height: 50,
          width: 150,
          color: kblackColor,
        ),
      ),
    );
  }
}
