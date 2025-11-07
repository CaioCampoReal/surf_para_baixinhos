import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import '../blocs/auth_cubit/auth_state.dart';
import '../widgets/molecules/register_form.dart';
import '../widgets/organisms/login_container.dart';
import '../widgets/organisms/app_bar_custom.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('As senhas não coincidem'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<AuthCubit>().register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _displayNameController.text.trim(),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? _validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu nome';
    }
    if (value.length < 2) {
      return 'O nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
        
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: const AppBarCustom(
          title: 'Criar Conta',
          backgroundColor: Colors.green,
          semanticLabel: 'Cabeçalho da tela de registro',
        ),
        body: Semantics(
          label: 'Tela de registro. Preencha nome, email e senha para criar uma nova conta.',
          child: Center(
            child: SingleChildScrollView(
              child: LoginContainer(
                child: RegisterForm(
                  emailController: _emailController,
                  displayNameController: _displayNameController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  formKey: _formKey,
                  onRegister: () => _register(context),
                  validateEmail: _validateEmail,
                  validateDisplayName: _validateDisplayName,
                  validatePassword: _validatePassword,
                  validateConfirmPassword: _validateConfirmPassword,
                  formWidth: 400,
                  emailSemanticHint: 'Digite um email válido com @ e .',
                  displayNameSemanticHint: 'Digite seu nome completo',
                  passwordSemanticHint: 'Digite sua senha com pelo menos 6 caracteres',
                  confirmPasswordSemanticHint: 'Digite a mesma senha novamente',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}