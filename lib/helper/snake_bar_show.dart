import 'package:flutter/material.dart';

void snakeBarShow(BuildContext context, String textShow) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Text(textShow, style: const TextStyle(color: Colors.blue)),
    ),
  );
}
