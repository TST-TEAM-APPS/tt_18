import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class TrainingComplete extends StatefulWidget {
  final String title;
  final String description;
  final int workoutTime;
  final int restTime;
  final String imagePath;
  final int repetitions;
  final String trainingType;
  final Function onConfirm;

  TrainingComplete({
    required this.title,
    required this.description,
    required this.workoutTime,
    required this.restTime,
    required this.repetitions,
    required this.imagePath,
    required this.trainingType,
    required this.onConfirm,
  });

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingComplete> {
  int currentRepetition = 0;
  int remainingTime = 0;
  bool isWorkout = true;
  Timer? timer;
  bool isPaused = false;

  late int workoutTimeInSeconds;
  late int restTimeInSeconds;

  @override
  void initState() {
    super.initState();

    workoutTimeInSeconds = widget.workoutTime * 60;
    restTimeInSeconds = widget.restTime * 60;

    startWorkout();
  }

  void startWorkout() {
    setState(() {
      isWorkout = true;
      remainingTime = workoutTimeInSeconds;
    });
    startTimer();
  }

  void showCompleteModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/onb1.png',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Your training is complete!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showFinishModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/onb1.png',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Want to finish your workout early?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        resumeTimer();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.grey,
                        ),
                        child: Text(
                          'Cancel',
                          style: AppFonts.displayMedium
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCompleteModal(context);
                        widget.onConfirm();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.surface,
                        ),
                        child: Text(
                          'Yes',
                          style: AppFonts.displayMedium
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void startRest() {
    setState(() {
      isWorkout = false;
      remainingTime = restTimeInSeconds;
    });
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            timer.cancel();
            if (isWorkout) {
              if (currentRepetition + 1 < widget.repetitions) {
                currentRepetition++;
                startRest();
              } else {
                showCompleteModal(context);
                widget.onConfirm();
              }
            } else {
              startWorkout();
            }
          }
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
    });
  }

  double getPercentage() {
    final totalTime = isWorkout ? workoutTimeInSeconds : restTimeInSeconds;
    return 1 - (remainingTime / totalTime);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icons/back.png',
                        width: 34,
                        height: 34,
                      ),
                    ),
                    Text(
                      widget.trainingType,
                      style: AppFonts.displaySmall
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(
                      height: 34,
                      width: 34,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.darkGrey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.surface,
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              widget.imagePath,
                              height: 315,
                              width: 315,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Completed ",
                                        style: AppFonts.displaySmall.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${currentRepetition + 1}/${widget.repetitions}",
                                        style: AppFonts.bodyLarge.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle),
                                  child: CircularPercentIndicator(
                                    radius: 32.0,
                                    lineWidth: 4.0,
                                    percent: getPercentage(),
                                    center: Text(
                                      "${(getPercentage() * 100).toInt()}%",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    progressColor: AppColors.surface,
                                    backgroundColor: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(20),
                  minHeight: 14,
                  value: isWorkout
                      ? remainingTime / workoutTimeInSeconds
                      : remainingTime / restTimeInSeconds,
                  color: AppColors.surface,
                  backgroundColor: AppColors.darkGrey,
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: AppColors.background,
                            border: Border.all(
                              width: 1,
                              color: AppColors.outlineGrey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}",
                                  style: AppFonts.bodyLarge
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!isPaused) {
                                    pauseTimer();
                                    setState(() {});
                                    return;
                                  }
                                  resumeTimer();
                                  setState(() {});
                                },
                                child: Container(
                                  height: 84,
                                  width: 84,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.surface),
                                  child: Icon(
                                      isPaused ? Icons.play_arrow : Icons.pause,
                                      color: AppColors.onSurface,
                                      size: 40),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // timer?.cancel();
                          pauseTimer();
                          showFinishModal(context);
                        },
                        child: Container(
                          height: 84,
                          width: 84,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.primary),
                          child: const Icon(Icons.stop_outlined,
                              color: AppColors.onSurface, size: 40),
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         timer?.cancel();
                //       },
                //       icon: Icon(Icons.pause, color: Colors.red, size: 40),
                //     ),
                //     SizedBox(width: 20),
                //     IconButton(
                //       onPressed: () {
                //         if (isWorkout) startWorkout();
                //       },
                //       icon:
                //           Icon(Icons.play_arrow, color: Colors.green, size: 40),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
