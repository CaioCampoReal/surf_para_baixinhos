import 'package:flutter/material.dart';
import '../atoms/copyright_text.dart';

class CopyrightSection extends StatelessWidget {
  final String copyrightText;

  const CopyrightSection({
    super.key,
    required this.copyrightText,
  });

  @override
  Widget build(BuildContext context) {
    return CopyrightText(text: copyrightText);
  }
}