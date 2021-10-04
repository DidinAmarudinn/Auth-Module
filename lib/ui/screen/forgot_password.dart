import 'package:auth_module/constants/app_constants.dart';
import 'package:auth_module/cubit/auth_cubit.dart';
import 'package:auth_module/ui/components/custom_button.dart';
import 'package:auth_module/ui/components/custom_textfield.dart';
import 'package:auth_module/ui/components/loading_indicator.dart';
import 'package:auth_module/ui/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  bool isLoading = false;
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
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                Get.back();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: kwhiteTextColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.navigate_before,
                    color: kblackColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultMargin),
            Text(
              "Lupa Password",
              style: primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
            const SizedBox(height: defaultMargin),
            CustomTextField(label: "Email", controller: _tEmail),
            const SizedBox(height: defaultMargin),
            CustomTextField(
              label: "Password Baru",
              isObssuerd: true,
              controller: _tPassword,
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
                        buttonName: "Ganti Password",
                        onPressed: () async {
                          if (_tEmail.text.isNotEmpty &&
                              _tPassword.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            await context
                                .read<AuthCubit>()
                                .forgotPass(_tEmail.text, _tPassword.text);
                            AuthState state = context.read<AuthCubit>().state;
                            if (state is ForgotPassLoaded) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Berhasil Ganti Password",
                                  ),
                                ),
                              );
                              Get.off(() => const LoginScreen());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    (state as ForgotPassFailed).message,
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
                                  "Masukan Email dan Password Baru",
                                ),
                              ),
                            );
                          }
                        },
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: kblackColor,
                      ),
          ],
        ),
      ),
    );
  }
}
