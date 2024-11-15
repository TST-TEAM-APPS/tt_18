import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/fitness_goals_add/fitness_goals_add_screen.dart';
import 'package:tt_18/futures/main/fitness_goals_add/logic/viewModel/fintess_goal_view_model.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _showBottomSheet(
      BuildContext context, Function? onChange, FitnessGoalModelHive model) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      model.imagePath,
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${DateFormat('dd MMM').format(model.startedDate)} - ${DateFormat('dd MMM yyyy').format(model.startedDate)}',
                      style: AppFonts.bodySmall.copyWith(
                        color: AppColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppFonts.displaySmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    if (model.description != null)
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${model.description}',
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                  ]),
              if (model.goal != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${model.currentProgress ?? 0}/${model.goal} kg',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.darkGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: model.currentProgress == null
                                ? 0
                                : 163 / model.goal! * model.currentProgress!,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ActivityViewModel>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentDateWIdget(
                  value: [
                    DateTime.now(),
                  ],
                  onChangeDate: () {},
                ),
                const SizedBox(
                  height: 35,
                ),
                const _ActivityLabel(),
                const SizedBox(
                  height: 15,
                ),
                const _ProgressWidget(),
                const SizedBox(
                  height: 23,
                ),
                if (model.fitnessState.fitnessGoalList.isEmpty)
                  _NothingWidget(
                    title: 'Fitness goals',
                    imagePath: 'assets/images/target.png',
                    text: 'No long-term goals',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FitnessGoalsAddScreen(
                                  model: model,
                                )),
                      );
                    },
                  ),
                if (model.fitnessState.fitnessGoalList.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fitness goals',
                            style: AppFonts.displayMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FitnessGoalsAddScreen(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: 163,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Material(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      highlightColor:
                                          AppColors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {},
                                      child: Container(
                                        width: 162,
                                        height: 163,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.transparent,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    model
                                                        .fitnessState
                                                        .fitnessGoalList[index]!
                                                        .imagePath,
                                                    width: 36,
                                                    height: 36,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${DateFormat('dd MMM').format(model.fitnessState.fitnessGoalList[index]!.startedDate)} - ${DateFormat('dd MMM yyyy').format(model.fitnessState.fitnessGoalList![index]!.startedDate)}',
                                                    style: AppFonts.bodySmall
                                                        .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    model
                                                        .fitnessState
                                                        .fitnessGoalList[index]!
                                                        .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: AppFonts.displaySmall
                                                        .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  if (model
                                                          .fitnessState
                                                          .fitnessGoalList[
                                                              index]!
                                                          .description !=
                                                      null)
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '${model.fitnessState.fitnessGoalList[index]!.description}',
                                                          style: AppFonts
                                                              .bodySmall
                                                              .copyWith(
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        )
                                                      ],
                                                    ),
                                                ]),
                                            if (model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .goal !=
                                                null)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${model.fitnessState.fitnessGoalList[index]!.currentProgress ?? 0}/${model.fitnessState.fitnessGoalList[index]!.goal} kg',
                                                    style: AppFonts.bodyMedium
                                                        .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .darkGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: model
                                                                      .fitnessState
                                                                      .fitnessGoalList[
                                                                          index]!
                                                                      .currentProgress ==
                                                                  null
                                                              ? 0
                                                              : 163 /
                                                                  model
                                                                      .fitnessState
                                                                      .fitnessGoalList[
                                                                          index]!
                                                                      .goal! *
                                                                  model
                                                                      .fitnessState
                                                                      .fitnessGoalList[
                                                                          index]!
                                                                      .currentProgress!,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount:
                                    model.fitnessState.fitnessGoalList.length),
                          ),
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                _NothingWidget(
                  title: 'Goals for the day',
                  imagePath: 'assets/images/target2.png',
                  text: 'There are no goals for today',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NothingWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String text;
  final Function onTap;
  const _NothingWidget({
    required this.title,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.displayMedium.copyWith(color: AppColors.onBackground),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              Image.asset(imagePath),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style:
                    AppFonts.displaySmall.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(
                height: 5,
              ),
              Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add',
                          style: AppFonts.displaySmall
                              .copyWith(color: AppColors.onSurface),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/plus.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressWidget extends StatelessWidget {
  const _ProgressWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your progress',
          style: AppFonts.displayMedium.copyWith(color: AppColors.onBackground),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Calories',
                        style: AppFonts.displaySmall
                            .copyWith(color: AppColors.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '0',
                            style: AppFonts.displayLarge
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          TextSpan(
                            text: '/0',
                            style: AppFonts.displaySmall
                                .copyWith(color: AppColors.onPrimary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Activity time',
                        style: AppFonts.displaySmall
                            .copyWith(color: AppColors.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '0',
                            style: AppFonts.displayLarge
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 2),
                          ),
                          TextSpan(
                            text: 'H',
                            style: AppFonts.displaySmall
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 10),
                          ),
                          TextSpan(
                            text: '0',
                            style: AppFonts.displayMedium
                                .copyWith(color: AppColors.onPrimary),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 2),
                          ),
                          TextSpan(
                            text: 'Min',
                            style: AppFonts.displaySmall
                                .copyWith(color: AppColors.onPrimary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _ActivityLabel extends StatelessWidget {
  const _ActivityLabel();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Activity',
      style: AppFonts.displayLarge.copyWith(color: AppColors.onBackground),
    );
  }
}
