import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const LoginContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}