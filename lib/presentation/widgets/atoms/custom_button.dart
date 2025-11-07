import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String? semanticLabel;
  final double? width;
  final bool? isEnabled; 

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.semanticLabel,
    this.width,
    this.isEnabled, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled ?? onPressed != null;
    
    return SizedBox(
      width: width,
      child: Semantics(
        label: semanticLabel ?? text,
        button: true,
        enabled: enabled,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled ? backgroundColor : Colors.grey,
            foregroundColor: textColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: enabled ? 2 : 0,
          ),
          child: Semantics(
            excludeSemantics: true,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: enabled ? textColor : textColor.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}