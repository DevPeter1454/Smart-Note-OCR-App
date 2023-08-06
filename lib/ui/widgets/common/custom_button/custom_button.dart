import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;

  final String text;
  final Size? size;
  final TextStyle style;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.text,
      this.size,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        fixedSize: size,
      ),
      child: Text(text, style: style),
    );
  }
}
