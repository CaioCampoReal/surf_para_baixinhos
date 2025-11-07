import 'package:flutter/material.dart';
import '../atoms/social_icon_button.dart';

class SocialMediaRow extends StatelessWidget {
  final VoidCallback onFacebookTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onTikTokTap;

  const SocialMediaRow({
    super.key,
    required this.onFacebookTap,
    required this.onInstagramTap,
    required this.onTikTokTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIconButton(
          icon: Icons.facebook,
          label: 'Facebook',
          onTap: onFacebookTap,
        ),
        
        const SizedBox(width: 20),
        
        SocialIconButton(
          icon: Icons.camera_alt,
          label: 'Instagram',
          onTap: onInstagramTap,
        ),
        
        const SizedBox(width: 20),
        
        SocialIconButton(
          icon: Icons.music_note,
          label: 'TikTok',
          onTap: onTikTokTap,
        ),
      ],
    );
  }
}