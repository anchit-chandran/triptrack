// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBarTitle = 'Trip Track',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
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
