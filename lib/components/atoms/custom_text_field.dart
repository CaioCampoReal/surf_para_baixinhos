import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final String? semanticLabel;
  final String? semanticHint; 
  final double? width;
  final TextInputType? keyboardType; 

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.semanticLabel,
    this.semanticHint, 
    this.width,
    this.keyboardType, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Semantics(
        label: semanticLabel ?? labelText,
        hint: semanticHint, 
        textField: true, 
        value: controller.text, 
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          autovalidateMode: autovalidateMode,
          keyboardType: keyboardType, 
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(prefixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ),
    );
  }
}