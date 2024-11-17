import 'package:flutter/material.dart';
import 'dart:async';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static const maxTime = 10 * 60;
  int currentTime = maxTime;
  int rounds = 0;
  Timer? timer;
  void startTimer() {
    if (timer != null && timer!.isActive) return;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (currentTime > 0) {
          currentTime--;
        } else {
          rounds++;
          resetTimer();
        }
      });
    });
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      currentTime = maxTime;
    });
  }

  void skipTime() {
    setState(() {
      currentTime = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: currentTime / maxTime,
                    strokeWidth: 20,
                    color: Colors.yellow,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${(currentTime ~/ 60).toString().padLeft(2, '0')}:${(currentTime % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mão na massa!',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: startTimer,
                  iconSize: 40,
                ),
                IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white),
                  onPressed: pauseTimer,
                  iconSize: 40,
                ),
                IconButton(
                  icon: const Icon(Icons.stop, color: Colors.white),
                  onPressed: resetTimer,
                  iconSize: 40,
                ),
                IconButton(
                  icon: const Icon(Icons.fast_forward, color: Colors.white),
                  onPressed: skipTime,
                  iconSize: 40,
                ),
              ],
            ),
            const SizedBox(height: 100),
            Text(
              'Rodadas: $rounds',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ]),
    );
  }
}
