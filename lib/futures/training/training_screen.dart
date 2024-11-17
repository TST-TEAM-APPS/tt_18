import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/training/model/training_hive_model.dart';
import 'package:tt_18/futures/training/training_complete_screen/training_complete.dart';
import 'package:tt_18/futures/training/training_details_screen/training_details_screen.dart';
import 'package:tt_18/futures/training/view_model/training_view_model.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  String _formatTime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours.toString().padLeft(2, '')} H ${remainingMinutes.toString().padLeft(2, '0')} Min';
  }

  String _getDayAbbreviation(int weekday) {
    const dayAbbreviations = ["M", "T", "W", "T", "F", "S", "S"];
    return dayAbbreviations[weekday - 1];
  }

  bool isEqual(TrainingHiveModel trainingHiveModel, DateTime dateTime) {
    bool? isTrue;
    for (var date in trainingHiveModel.completedDates) {
      if (date.year == dateTime.year &&
          date.month == dateTime.month &&
          date.day == dateTime.day) {
        isTrue = true;
      }
    }
    return isTrue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TrainingViewModel>();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CurrentDateWIdget(
                value: [
                  model.trainingState.currentDate ?? DateTime.now(),
                ],
                onChangeDate: (value) {
                  model.onUpdatedDate(value);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s training',
                    style: AppFonts.displayMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TrainingDetailsScreen(
                                  model: model,
                                )),
                      );
                    },
                    child: Image.asset(
                      'assets/icons/rounded-plus.png',
                      width: 34,
                      height: 34,
                    ),
                  )
                ],
              ),
              if (model.trainingState.isLoading)
                const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                ),
              if (model.trainingState.trainingList.isEmpty &&
                  !model.trainingState.isLoading)
                SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/images/onb2.png',
                        height: 105,
                        width: 105,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No training for today',
                        style:
                            AppFonts.displaySmall.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Press + to add',
                        style:
                            AppFonts.bodyMedium.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              if (model.trainingState.trainingList.isNotEmpty &&
                  !model.trainingState.isLoading)
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = model.trainingState.trainingList[index];
                          return Container(
                            height: 141,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.grey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      item!.trainingType.imagePath,
                                      width: 85,
                                      height: 85,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppFonts.displaySmall
                                                  .copyWith(
                                                color: AppColors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 14,
                                              child: PullDownButton(
                                                itemBuilder: (context) => [
                                                  PullDownMenuItem(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              TrainingDetailsScreen(
                                                            model: model,
                                                            trainingHiveModel:
                                                                item,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    title: 'Edit',
                                                    icon: CupertinoIcons.pencil,
                                                  ),
                                                  PullDownMenuItem(
                                                    onTap: () {
                                                      model.onDeleteTraining(
                                                          item);
                                                    },
                                                    title: 'Delete',
                                                    iconColor: Colors.red,
                                                    icon: CupertinoIcons.delete,
                                                  ),
                                                ],
                                                buttonBuilder:
                                                    (context, showMenu) =>
                                                        CupertinoButton(
                                                  onPressed: showMenu,
                                                  padding: EdgeInsets.zero,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: const Icon(
                                                      Icons.more_horiz,
                                                      size: 24,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          _formatTime(
                                              item.restTime * item.numberOfRep +
                                                  item.workingTime *
                                                      item.numberOfRep),
                                          style: AppFonts.bodySmall
                                              .copyWith(color: AppColors.white),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.description,
                                          style: AppFonts.bodySmall
                                              .copyWith(color: AppColors.white),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 25,
                                          child: Row(
                                            children: List.generate(
                                                item.reireration.length, (ind) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Container(
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppColors
                                                              .primary),
                                                  child: Center(
                                                    child: Text(
                                                      _getDayAbbreviation(item
                                                          .reireration[ind]),
                                                      style: AppFonts.bodyMedium
                                                          .copyWith(
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => TrainingComplete(
                                                  onConfirm: () {
                                                    model.onTaskComplete(
                                                      TrainingHiveModel(
                                                          id: item.id,
                                                          name: item.name,
                                                          description:
                                                              item.description,
                                                          reireration:
                                                              item.reireration,
                                                          numberOfRep:
                                                              item.numberOfRep,
                                                          restTime:
                                                              item.restTime,
                                                          workingTime:
                                                              item.workingTime,
                                                          trainingType:
                                                              item.trainingType,
                                                          completedDates: item
                                                              .completedDates),
                                                    );
                                                  },
                                                  trainingType:
                                                      item.trainingType.name,
                                                  imagePath: item
                                                      .trainingType.imagePath,
                                                  title: item.name,
                                                  description: item.description,
                                                  workoutTime: item.workingTime,
                                                  repetitions: item.numberOfRep,
                                                  restTime: item.restTime,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isEqual(item,
                                              model.trainingState.currentDate!)
                                          ? AppColors.surface
                                          : AppColors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: 38,
                                    child: Center(
                                      child: isEqual(item,
                                              model.trainingState.currentDate!)
                                          ? Image.asset(
                                              'assets/icons/tick.png',
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/icons/pause.png',
                                              width: 14,
                                              height: 15,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: model.trainingState.trainingList.length),
                  ],
                )
            ],
          ),
        ),
      ),
    ));
  }
}
