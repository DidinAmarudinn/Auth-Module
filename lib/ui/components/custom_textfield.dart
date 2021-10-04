import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isObssuerd;
  const CustomTextField(
      {Key? key,
      required this.label,
      required this.controller,
      this.isObssuerd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: TextField(
          controller: controller,
          obscureText: isObssuerd,
          decoration: InputDecoration(
              hintText: label,
              contentPadding: const EdgeInsets.all(15),
              border: InputBorder.none),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
