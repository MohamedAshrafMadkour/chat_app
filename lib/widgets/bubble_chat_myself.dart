import 'package:cheat_app/model/message.dart';
import 'package:flutter/material.dart';

class BubbleChatMyself extends StatelessWidget {
  const BubbleChatMyself({
    super.key,
    required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(bottom: 32, top: 32, left: 8, right: 16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 24, 54, 99),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16)),
        ),
        margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
        child: Text(
          textAlign: TextAlign.left,
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
