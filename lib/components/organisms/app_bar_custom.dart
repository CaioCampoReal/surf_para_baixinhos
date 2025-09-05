import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;
  final bool centerTitle;
  final String? semanticLabel; 

  const AppBarCustom({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.actions,
    this.centerTitle = true,
    this.semanticLabel, 
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? 'Cabeçalho $title',
      header: true, 
      child: AppBar(
        title: Semantics(
          excludeSemantics: true,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        actions: actions,
        centerTitle: centerTitle,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8),
          ),
        ),
      ),
    );
  }
}