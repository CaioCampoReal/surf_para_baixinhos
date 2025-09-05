import 'package:flutter/material.dart';
import '../atoms/custom_text_field.dart';
import '../atoms/custom_button.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usuarioController;
  final TextEditingController emailController; 
  final TextEditingController senhaController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onLogin;
  final String? Function(String?)? validarUsuario;
  final String? Function(String?)? validarEmail; 
  final String? Function(String?)? validarSenha;
  final double formWidth;
  final String? usuarioSemanticHint;
  final String? emailSemanticHint; 
  final String? senhaSemanticHint;

  const LoginForm({
    Key? key,
    required this.usuarioController,
    required this.emailController, 
    required this.senhaController,
    required this.formKey,
    required this.onLogin,
    this.validarUsuario,
    this.validarEmail, 
    this.validarSenha,
    this.formWidth = 400,
    this.usuarioSemanticHint = 'Digite seu nome de usuário',
    this.emailSemanticHint = 'Digite seu email',
    this.senhaSemanticHint = 'Digite sua senha',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: formWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: usuarioController,
                labelText: 'Usuário',
                prefixIcon: Icons.person,
                validator: validarUsuario,
                width: double.infinity,
                semanticHint: usuarioSemanticHint,
                semanticLabel: 'Campo de usuário',
              ),
              const SizedBox(height: 20),
              
              // NOVO CAMPO EMAIL
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: validarEmail,
                width: double.infinity,
                semanticHint: emailSemanticHint,
                semanticLabel: 'Campo de email',
              ),
              const SizedBox(height: 20),
              
              CustomTextField(
                controller: senhaController,
                labelText: 'Senha',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: validarSenha,
                width: double.infinity,
                semanticHint: senhaSemanticHint,
                semanticLabel: 'Campo de senha',
              ),
              const SizedBox(height: 36),
              
              Semantics(
                button: true,
                label: 'Botão para fazer login no sistema',
                child: CustomButton(
                  text: 'Entrar',
                  onPressed: onLogin,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  width: double.infinity,
                  semanticLabel: 'Entrar no aplicativo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}