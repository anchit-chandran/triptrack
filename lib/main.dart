// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'dart:async';

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
  Duration duration = Duration();
  Timer? timer;
  bool timerStarted = false;

  void toggleTimer() {
    // cancel current timer
    timer?.cancel();

    if (!timerStarted) {
      print('Starting timer');
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    } else {
      print("Pausing timer");
    }

    // flip timerStarted state
    setState(() {
      timerStarted = !timerStarted;
    });
  }

  void stopTimer() {
    print("Stopping timer");

    timer?.cancel();
    setState(() {
      timerStarted = false;
      duration = Duration.zero;
    });
  }

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  String durationToString(Duration duration) {
    String hours = duration.inHours.remainder(60).toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  Future<dynamic> confirmStopTrip(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Cancel trip?"),
              elevation: 24.0,
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    "Are you sure you want to end the trip? The timer will be stopped."),
              ),
              contentPadding: EdgeInsets.all(6.0),
              actions: [
                TextButton(
                    onPressed: () {
                      print("Ending timer");
                      stopTimer();
                      Navigator.of(context).pop();
                    },
                    child: Text("End trip")),
                TextButton(
                    onPressed: () {
                      print("Continuing timer");
                      Navigator.of(context).pop();
                    },
                    child: Text("Continue")),
              ],
            ));
  }

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
              child: Column(children: [
                SubstanceAvatar(
                  avatar: "💊",
                ),
                TimerContainer(
                  tripDuration: durationToString(duration),
                ),
              ]),
            ),
            ActionButtonsContainer(
              toggleTimer: toggleTimer,
              timerStarted: timerStarted,
              duration: duration,
              confirmStopTrip: confirmStopTrip,
            )
          ],
        ),
      ),
    );
  }
}

class ActionButtonsContainer extends StatefulWidget {
  final VoidCallback toggleTimer;
  final bool timerStarted;
  final Duration duration;
  final Future<dynamic> Function(BuildContext) confirmStopTrip;

  const ActionButtonsContainer({
    super.key,
    required this.toggleTimer,
    required this.timerStarted,
    required this.duration,
    required this.confirmStopTrip,
  });

  @override
  State<ActionButtonsContainer> createState() => _ActionButtonsContainerState();
}

class _ActionButtonsContainerState extends State<ActionButtonsContainer> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(onPressed: () {}, icon: Icon(Icons.fast_rewind)),
          ActionButton(
              onPressed: () {
                print("Starting timer");
                widget.toggleTimer();
              },
              icon: Icon(widget.timerStarted ? Icons.pause : Icons.play_arrow)),
          if (widget.duration.inSeconds > 0)
            ActionButton(
                onPressed: () {
                  // Confirm cancel trip
                  widget.confirmStopTrip(context);
                },
                icon: Icon(Icons.stop)),
          ActionButton(
            onPressed: () {},
            icon: Icon(Icons.fast_forward),
          ),
        ],
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
    required this.tripDuration,
  });

  final String tripDuration;

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
          TimerText(
            time: tripDuration,
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

class TimerText extends StatelessWidget {
  final String time;

  const TimerText({
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
