import 'package:flutter/material.dart';

class ContainerLogin extends StatelessWidget {
  const ContainerLogin({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xff465DBB),
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
