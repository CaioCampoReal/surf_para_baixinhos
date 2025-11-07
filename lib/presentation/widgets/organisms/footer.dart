import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../molecules/social_media_row.dart';
import '../molecules/contact_info_section.dart';
import '../molecules/copyright_section.dart';

class Footer extends StatelessWidget {
  final String phone;
  final String email;
  final String copyrightText;
  
  const Footer({
    super.key,
    this.phone = '(42) 99915-6875',
    this.email = 'contato@surfprabaixinhos.com.br',
    this.copyrightText = '© 2025 Surf Para Baixinhos. Todos os direitos reservados.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SocialMediaRow(
            onFacebookTap: () => _launchUrl(context, 'https://facebook.com'),
            onInstagramTap: () => _launchUrl(context, 'https://instagram.com'),
            onTikTokTap: () => _launchUrl(context, 'https://tiktok.com'),
          ),
          
          const SizedBox(height: 20),
          
          ContactInfoSection(
            phone: phone,
            email: email,
            onPhoneTap: () => _launchUrl(context, 'tel:$phone'),
            onEmailTap: () => _launchUrl(context, 'mailto:$email'),
          ),
          
          const SizedBox(height: 20),
          
          CopyrightSection(
            copyrightText: copyrightText,
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        _showErrorSnackbar(context, 'Não foi possível abrir o link');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Erro ao abrir link: $e');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}