import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chosenTime = 25;
  int totalSeconds = 25 * 60;
  int totalPomodoros = 0;
  int totalGoal = 0;
  bool isRunning = false;
  bool isBreakTime = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalGoal == 12) return;
    if (totalSeconds == 0 && isRunning == true) {
      setState(() {
        totalPomodoros++;
        totalSeconds = chosenTime * 1;
        onPausePressed();
        if (totalPomodoros == 4) {
          totalGoal++;
          totalPomodoros = 0;
          totalSeconds = 300;
          onBreakTime();
        }
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStartPressed() {
    if (isBreakTime == true) return;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onBreak() {
    setState(() {
      if (totalSeconds == 0) {
        onPausePressed();
        totalSeconds = chosenTime * 60;
      } else {
        totalSeconds--;
      }
    });
  }

  void onBreakTime() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isBreakTime = true;
    });
  }

  String timeFormat(int seconds) {
    return Duration(seconds: seconds)
        .toString()
        .split('.')
        .first
        .substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'POMOTIMER',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Text(
                        timeFormat(totalSeconds).split(':')[0],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Text(
                        timeFormat(totalSeconds).split(':')[1],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (chosenTime != 15 || totalSeconds != 15 * 60) {
                            if (!(isBreakTime || isRunning)) {
                              totalSeconds = 15 * 60;
                              chosenTime = 15;
                            }
                          }
                        });
                      },
                      child: timeCard(time: 15, chosen: chosenTime),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (chosenTime != 20 || totalSeconds != 20 * 60) {
                            if (!(isBreakTime || isRunning)) {
                              totalSeconds = 20 * 60;
                              chosenTime = 20;
                            }
                          }
                        });
                      },
                      child: timeCard(time: 20, chosen: chosenTime),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (chosenTime != 25 || totalSeconds != 25 * 60) {
                            if (!(isBreakTime || isRunning)) {
                              totalSeconds = 25 * 60;
                              chosenTime = 25;
                            }
                          }
                        });
                      },
                      child: timeCard(time: 25, chosen: chosenTime),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (chosenTime != 30 || totalSeconds != 30 * 60) {
                            if (!(isBreakTime || isRunning)) {
                              totalSeconds = 30 * 60;
                              chosenTime = 30;
                            }
                          }
                        });
                      },
                      child: timeCard(time: 30, chosen: chosenTime),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (chosenTime != 35 || totalSeconds == 35 * 60) {
                            if (!(isBreakTime || isRunning)) {
                              totalSeconds = 35 * 60;
                              chosenTime = 35;
                            }
                          }
                        });
                      },
                      child: timeCard(time: 35, chosen: chosenTime),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                IconButton(
                  iconSize: 100,
                  color: Theme.of(context).cardColor,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(!isRunning
                      ? Icons.play_circle_outline
                      : Icons.pause_circle),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$totalPomodoros/4',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'ROUND',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$totalGoal/12',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'GOAL',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class timeCard extends StatelessWidget {
  final int time;
  final int chosen;

  const timeCard({super.key, required this.time, required this.chosen});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: time == chosen
            ? Colors.white
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Text(
          '$time',
          style: TextStyle(
            color: time == chosen
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).cardColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
