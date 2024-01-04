// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:triptrack/screens/timer_screen.dart';

import 'package:triptrack/screens/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const List<String> SUBSTANCEOPTIONS = [
    '💊',
    '🍄',
    '👩‍⚖️',
    '🦄',
    '🧪'
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedSubstance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                30,
              ),
              child: Text(
                'Welcome to Trip Track!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            DropdownButton(
                value: selectedSubstance,
                hint: Text(
                  'Choose your trip buddy',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                items: HomeScreen.SUBSTANCEOPTIONS
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSubstance = newValue;
                  });
                  print('set selectedSubstance to $selectedSubstance');
                }),
            Column(
              children: [
                selectedSubstance != null
                    ? Text(
                        "You've chosen $selectedSubstance!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Choose a partner!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: selectedSubstance != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimerScreen(
                                        selectedSubstance: selectedSubstance!,
                                      )),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        disabledBackgroundColor:
                            Color.fromARGB(82, 158, 158, 158),
                        disabledForegroundColor:
                            Color.fromARGB(82, 158, 158, 158)),
                    child: Text(
                      'Start Trip',
                      style: TextStyle(
                        color: selectedSubstance != null
                            ? Colors.white
                            : Color.fromARGB(224, 173, 173, 173),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
