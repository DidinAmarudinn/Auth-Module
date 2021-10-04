import 'package:auth_module/constants/app_constants.dart';
import 'package:auth_module/cubit/cubit.dart';
import 'package:auth_module/model/register_entry.dart';
import 'package:auth_module/ui/components/custom_button.dart';
import 'package:auth_module/ui/components/custom_textfield.dart';
import 'package:auth_module/ui/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _tUsername = TextEditingController();
  final _tContactNumber = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultMargin),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hii,\nDaftar Sekarang",
                  style:
                      primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
                ),
                const SizedBox(height: defaultMargin * 2),
                CustomTextField(label: "Username", controller: _tUsername),
                const SizedBox(height: defaultMargin),
                CustomTextField(label: "Email", controller: _tEmail),
                const SizedBox(height: defaultMargin),
                CustomTextField(
                    label: "Contact Number", controller: _tContactNumber),
                const SizedBox(height: defaultMargin),
                CustomTextField(
                  label: "Password",
                  controller: _tPassword,
                ),
                const SizedBox(height: defaultMargin),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: kblackColor,
                        strokeWidth: 3,
                      ))
                    : CustomButtonWidget(
                        buttonName: "Register",
                        onPressed: () async {
                          if (_tEmail.text.isNotEmpty &&
                              _tPassword.text.isNotEmpty &&
                              _tContactNumber.text.isNotEmpty &&
                              _tUsername.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            final registEntry = RegisterEntry(
                                contacNumber: _tContactNumber.text,
                                fullName: _tUsername.text,
                                userName: "",
                                email: _tEmail.text,
                                password: _tPassword.text);
                            await context.read<AuthCubit>().signUp(registEntry);
                            AuthState state = context.read<AuthCubit>().state;
                            if (state is RegisterLoaded) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Registrasi Berhasil",
                                  ),
                                ),
                              );
                              Get.off(() => const LoginScreen());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Registrasi Gagal",
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
                                  "Isi semua kolom diatas",
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
                      "Sudah punya akun? ",
                      style: primaryTextStyle.copyWith(
                          fontWeight: light,
                          color: kblackColor.withOpacity(0.7)),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text(
                          "Login Sekarang",
                          style: primaryTextStyle,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
