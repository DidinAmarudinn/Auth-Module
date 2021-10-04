import 'package:auth_module/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonName;
  final Function onPressed;
  final double height;
  final Color color;
  final double width;
  const CustomButtonWidget(
      {Key? key,
      required this.buttonName,
      required this.onPressed,
      required this.height,
      required this.width,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(buttonName,
            style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium)),
      ),
    );
  }
}
