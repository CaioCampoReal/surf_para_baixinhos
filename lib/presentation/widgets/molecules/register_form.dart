import 'package:flutter/material.dart';
import '../atoms/custom_text_field.dart';
import '../atoms/custom_button.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController displayNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onRegister;
  final String? Function(String?)? validateEmail;
  final String? Function(String?)? validateDisplayName;
  final String? Function(String?)? validatePassword;
  final String? Function(String?)? validateConfirmPassword;
  final double formWidth;
  final String? emailSemanticHint;
  final String? displayNameSemanticHint;
  final String? passwordSemanticHint;
  final String? confirmPasswordSemanticHint;

  const RegisterForm({
    Key? key,
    required this.emailController,
    required this.displayNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onRegister,
    this.validateEmail,
    this.validateDisplayName,
    this.validatePassword,
    this.validateConfirmPassword,
    this.formWidth = 400,
    this.emailSemanticHint = 'Digite seu email',
    this.displayNameSemanticHint = 'Digite seu nome completo',
    this.passwordSemanticHint = 'Digite sua senha',
    this.confirmPasswordSemanticHint = 'Confirme sua senha',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: formWidth,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: displayNameController,
              labelText: 'Nome Completo',
              prefixIcon: Icons.person,
              validator: validateDisplayName,
              width: double.infinity,
              semanticHint: displayNameSemanticHint,
              semanticLabel: 'Campo de nome completo',
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              width: double.infinity,
              semanticHint: emailSemanticHint,
              semanticLabel: 'Campo de email',
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              controller: passwordController,
              labelText: 'Senha',
              prefixIcon: Icons.lock,
              obscureText: true,
              validator: validatePassword,
              width: double.infinity,
              semanticHint: passwordSemanticHint,
              semanticLabel: 'Campo de senha',
            ),
            const SizedBox(height: 20),
            
            CustomTextField(
              controller: confirmPasswordController,
              labelText: 'Confirmar Senha',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              validator: validateConfirmPassword,
              width: double.infinity,
              semanticHint: confirmPasswordSemanticHint,
              semanticLabel: 'Campo de confirmar senha',
            ),
            const SizedBox(height: 36),
            
            Semantics(
              button: true,
              label: 'Botão para criar nova conta',
              child: CustomButton(
                text: 'Criar Conta',
                onPressed: onRegister,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                width: double.infinity,
                semanticLabel: 'Criar nova conta',
              ),
            ),
            
            const SizedBox(height: 20),
            
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Já tem uma conta? Faça login',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}