// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Track',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 183, 22, 7)),
        useMaterial3: true,
      ),
      home: TripTrackApp(),
    );
  }
}

class TripTrackApp extends StatefulWidget {
  const TripTrackApp({super.key});

  @override
  State<TripTrackApp> createState() => _TripTrackAppState();
}

class _TripTrackAppState extends State<TripTrackApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Trip Track',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                child: Column(children: [
                  SubstanceAvatar(
                    avatar: "💊",
                  ),
                  TimerContainer()
                ]),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(onPressed: () {}, icon: Icon(Icons.fast_rewind)),
                  ActionButton(onPressed: () {}, icon: Icon(Icons.check)),
                  ActionButton(
                      onPressed: () {}, icon: Icon(Icons.fast_forward)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Icon icon;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: icon,
    );
  }
}

class TimerContainer extends StatelessWidget {
  const TimerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TimerLabel(),
          Timer(
            time: "01:00:00",
          ),
          TripLocation(
            location: "Come Up",
          )
        ],
      ),
    );
  }
}

class TripLocation extends StatelessWidget {
  final String location;
  const TripLocation({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Text(location,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                )),
          ),
        ),
      ],
    );
  }
}

class Timer extends StatelessWidget {
  final String time;

  const Timer({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(time,
            style: TextStyle(
              fontSize: 38,
              letterSpacing: 10.0,
              color: Colors.white,
            ))
      ],
    );
  }
}

class TimerLabel extends StatelessWidget {
  const TimerLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "hh : mm : ss",
          style: TextStyle(
            letterSpacing: 10.0,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class SubstanceAvatar extends StatelessWidget {
  final String avatar;

  const SubstanceAvatar({
    super.key,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Center(
        child: Text(
          avatar,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
