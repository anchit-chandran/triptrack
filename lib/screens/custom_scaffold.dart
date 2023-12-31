// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final Color backgroundColor;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBarTitle = 'Trip Track',
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            appBarTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: body);
  }
}
