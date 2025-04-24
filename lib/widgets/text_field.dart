import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      required this.titleFiled,
      this.onChanged,
      this.secure = false});
  final String titleFiled;
  final Function(String)? onChanged;
  final bool secure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secure,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Empty form';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: titleFiled,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
