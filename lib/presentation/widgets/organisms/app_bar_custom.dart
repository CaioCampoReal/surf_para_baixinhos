import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor; 
  final List<Widget>? actions; 
  final bool centerTitle;
  final String? semanticLabel;

  const AppBarCustom({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white, 
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
              color: Colors.white, 
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor, 
        actions: actions, 
        centerTitle: centerTitle,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8),
          ),
        ),
        iconTheme: IconThemeData(color: foregroundColor),
      ),
    );
  }
}