import 'package:flutter/material.dart';
import 'package:meu_projeto_integrador/screens/login_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Integrador',
      theme: appTheme,
      
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
