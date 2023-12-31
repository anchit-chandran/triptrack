// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:triptrack/screens/custom_scaffold.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
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
                  child: Text(
                    "End trip",
                    style: TextStyle(
                      color: Color.fromARGB(255, 244, 106, 101),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print("Continuing timer");
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 15, 78, 130),
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Have a good trip ☀️",
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
          ActionButton(
            onPressed: () {
              print("Starting timer");
              widget.toggleTimer();
            },
            icon: Icon(widget.timerStarted ? Icons.pause : Icons.play_arrow),
            color: widget.timerStarted ? Colors.purple : Colors.green,
          ),
          if (widget.duration.inSeconds > 0)
            ActionButton(
                onPressed: () {
                  // Confirm cancel trip
                  widget.confirmStopTrip(context);
                },
                icon: Icon(Icons.stop)),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Icon icon;
  final Color color;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: color,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Colors.white,
      ),
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
