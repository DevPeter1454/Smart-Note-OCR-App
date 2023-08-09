import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kcPrimaryColor.withOpacity(0.1),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back,
          color: kcPrimaryColor,
        ),
      ),
    );
  }
}
