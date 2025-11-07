import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen.dart';
import '../blocs/auth_cubit/auth_state.dart';
import '../widgets/molecules/login_form.dart';
import '../widgets/organisms/login_container.dart';
import '../widgets/organisms/app_bar_custom.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usuarioController.dispose();
    _emailController.dispose(); 
    _senhaController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
        email: _emailController.text.trim(),
        password: _senhaController.text,
      );
    }
  }

  String? _validarUsuario(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu usuário';
    }
    if (value.length < 3) {
      return 'O usuário deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
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
          title: 'Login',
          backgroundColor: Colors.blue,
          semanticLabel: 'Cabeçalho da tela de login',
        ),
        body: Semantics(
          label: 'Tela de login. Preencha usuário, email e senha para acessar o aplicativo.',
          child: Center(
            child: SingleChildScrollView(
              child: LoginContainer(
                child: Column(
                  children: [
                    LoginForm(
                      usuarioController: _usuarioController,
                      emailController: _emailController,
                      senhaController: _senhaController,
                      formKey: _formKey,
                      onLogin: () => _login(context),
                      validarUsuario: _validarUsuario,
                      validarEmail: _validarEmail,
                      validarSenha: _validarSenha,
                      formWidth: 400,
                      usuarioSemanticHint: 'Digite seu nome de usuário com pelo menos 3 caracteres',
                      emailSemanticHint: 'Digite um email válido com @ e .',
                      senhaSemanticHint: 'Digite sua senha com pelo menos 6 caracteres',
                    ),
                    
                    const SizedBox(height: 20),
                    
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Não tem uma conta? Cadastre-se',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}