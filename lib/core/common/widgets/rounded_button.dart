import 'package:flutter/material.dart';
import 'package:job_landing_course/core/res/colors.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;

  const RoundedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonColour,
    this.labelColour,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour ?? Colours.primaryColor,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
