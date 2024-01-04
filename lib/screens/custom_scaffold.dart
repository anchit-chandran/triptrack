// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final Color backgroundColor;
  final VoidCallback? customBackButtonCleanUp;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBarTitle = 'Trip Track',
    required this.backgroundColor,
    this.customBackButtonCleanUp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    if (customBackButtonCleanUp != null) {
                      customBackButtonCleanUp!();
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios),
                )
              : null,
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
