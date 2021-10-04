import 'package:auth_module/constants/app_constants.dart';
import 'package:auth_module/cubit/auth_cubit.dart';
import 'package:auth_module/model/models.dart';
import 'package:auth_module/ui/components/custom_button.dart';
import 'package:auth_module/ui/components/custom_textfield.dart';
import 'package:auth_module/ui/components/loading_indicator.dart';
import 'package:auth_module/ui/screen/forgot_password.dart';
import 'package:auth_module/ui/screen/main_screen.dart';
import 'package:auth_module/ui/screen/register_screen.dart';
import 'package:auth_module/utils/preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  bool isLoading = false;
  PreferenceHelper preferenceHelper =
      PreferenceHelper(SharedPreferences.getInstance());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hii,\nLogin Sekarang",
              style: primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
            const SizedBox(height: defaultMargin * 2),
            CustomTextField(label: "Email", controller: _tEmail),
            const SizedBox(height: defaultMargin),
            CustomTextField(
              label: "Password",
              isObssuerd: true,
              controller: _tPassword,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.to(() => ForgotPassword());
                },
                child: Text(
                  "Lupa Password?",
                  style: primaryTextStyle,
                ),
              ),
            ),
            const SizedBox(height: defaultMargin),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: kblackColor,
                    strokeWidth: 3,
                  ))
                : isLoading
                    ? const LoadingIndicator()
                    : CustomButtonWidget(
                        buttonName: "Login",
                        onPressed: () async {
                          if (_tEmail.text.isNotEmpty &&
                              _tPassword.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            await context
                                .read<AuthCubit>()
                                .signIn(_tEmail.text, _tPassword.text);
                            AuthState state = context.read<AuthCubit>().state;
                            if (state is UserLoaded) {
                              preferenceHelper.setEmail(_tEmail.text);
                              preferenceHelper
                                  .setId(state.user.userId.toString());
                              preferenceHelper.setToken(state.user.token ?? "");
                              Get.off(() => const MainScreen());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    (state as UserLoadingFailed).message,
                                  ),
                                ),
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Masukan Email dan Password",
                                ),
                              ),
                            );
                          }
                        },
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: kblackColor,
                      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun? ",
                  style: primaryTextStyle.copyWith(
                      fontWeight: light, color: kblackColor.withOpacity(0.7)),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: Text(
                      "Daftar Sekarang",
                      style: primaryTextStyle,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
