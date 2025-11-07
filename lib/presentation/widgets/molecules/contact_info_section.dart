import 'package:flutter/material.dart';
import '../atoms/contact_info_item.dart';

class ContactInfoSection extends StatelessWidget {
  final String phone;
  final String email;
  final VoidCallback? onPhoneTap; 
  final VoidCallback? onEmailTap; 

  const ContactInfoSection({
    super.key,
    required this.phone,
    required this.email,
    this.onPhoneTap,
    this.onEmailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactInfoItem(
          icon: Icons.phone,
          text: phone,
          onTap: onPhoneTap,
        ),
        
        const SizedBox(height: 8),
        
        ContactInfoItem(
          icon: Icons.email,
          text: email,
          onTap: onEmailTap,
        ),
      ],
    );
  }
}