import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;

  const MyField({
    super.key,
    this.validator,
    required this.controller,
    this.filled = false,
    this.fillColour,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.overrideValidator = false,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: controller,
        validator: overrideValidator
            ? validator
            : (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return validator?.call(value);
              },
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: filled,
          fillColor: fillColour,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: hintStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
