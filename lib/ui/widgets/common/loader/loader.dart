import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smartnote/ui/common/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        color: kcButtonColor, // Customize the color of the loading spinner.
        size: 70.0, // Customize the size of the loading spinner.
      ),
    );
  }
}
