import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_cupertino_picker.dart';

import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/components/custom_text_field.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/main/day_goal_add/day_goad_adding_screen.dart/day_goal_adding_screen.dart';
import 'package:tt_18/futures/main/fitness_goals_add/fitness_goal_detail/fitness_goal_detail_screen.dart';
import 'package:tt_18/futures/main/fitness_goals_add/fitness_goals_add_screen.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model.dart';
import 'package:tt_18/futures/main/view_model/activity_view_model.dart';
import 'package:tt_18/futures/main/fitness_goals_add/model/fitness_goal_model_hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, String> tagAssetsMap = {
    'Losing weight': 'assets/icons/loosing-weight.png',
    'Muscle mass gain': 'assets/icons/muscle-mass.png',
    'Increased strength': 'assets/icons/increased-strength.png',
    'Improved endurance': 'assets/icons/improved-endurance.png',
    'Improved flexibility': 'assets/icons/improved-flexibility.png',
  };

  String _getDayAbbreviation(int weekday) {
    const dayAbbreviations = ["M", "T", "W", "T", "F", "S", "S"];
    return dayAbbreviations[weekday - 1];
  }

  bool _isChecked = false;

  void _toggleCheck(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _showChangeGoalBottomSheet(
      BuildContext context, FitnessGoalModelHive model, onChange) {
    int selectedValue = model.currentProgress ?? 1;
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icons/back.png',
                        width: 34,
                        height: 34,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    model.format == 'Km' ? model.format! : 'Kg',
                    style: AppFonts.displayMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: AppColors.white,
                        )),
                    child: CustomCupertinoPicker(
                      value: selectedValue,
                      onChange: (value) {
                        selectedValue = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Save',
                    onTap: () {
                      onChange(selectedValue);
                    },
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: AppColors.primary,
                    highlightColor: Colors.white.withOpacity(0.5),
                    titleStyle: AppFonts.displaySmall.copyWith(
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showBottomSheet(BuildContext context, Function? onChange,
      FitnessGoalModelHive model, ActivityViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
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
                    Row(
                      children: [
                        Text(
                          model.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppFonts.displaySmall.copyWith(
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
                                    MaterialPageRoute(builder: (context) {
                                      final fitnessGoal =
                                          fitnessGoalModelList.firstWhere(
                                        (e1) {
                                          return e1.imagePath ==
                                              model.imagePath;
                                        },
                                        orElse: () =>
                                            fitnessGoalModelList.first,
                                      );

                                      return FitnessGoalDetailScreen(
                                        viewModel: viewModel,
                                        model: fitnessGoal,
                                        fitnessGoalModelHive: model,
                                      );
                                    }),
                                  );
                                },
                                title: 'Edit',
                                icon: CupertinoIcons.pencil,
                              ),
                              PullDownMenuItem(
                                onTap: () {
                                  viewModel.onDeleteFitnessGoal(model);
                                  Navigator.pop(context);
                                },
                                title: 'Delete',
                                iconColor: Colors.red,
                                icon: CupertinoIcons.delete,
                              ),
                            ],
                            buttonBuilder: (context, showMenu) =>
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
                        )
                      ],
                    ),
                    Text(
                      '${DateFormat('dd MMM').format(model.startedDate)} - ${DateFormat('dd MMM yyyy').format(model.startedDate)}',
                      style: AppFonts.bodySmall.copyWith(
                        color: AppColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                      height: 5,
                    ),
                    BottomSheetText(
                        text:
                            '${model.currentProgress ?? 0}/${model.goal}${model.goal != null && model.description != null ? 'Km' : 'Kg'}'),
                    const SizedBox(
                      height: 5,
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
                          Container(
                            width: model.currentProgress == null
                                ? 0
                                : model.currentProgress! > model.goal!
                                    ? double.infinity
                                    : (MediaQuery.of(context).size.width - 40) /
                                        model.goal! *
                                        model.currentProgress!,
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
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: model.description != null && model.goal == null
                    ? 'Mark as completed'
                    : 'Add progress',
                onTap: () {
                  model.description != null && model.goal == null
                      ? Navigator.pop(context)
                      : _showChangeGoalBottomSheet(
                          context,
                          model,
                          (value) {
                            onChange!(value);
                          },
                        );
                },
                borderRadius: BorderRadius.circular(20),
                backgroundColor: AppColors.primary,
                titleStyle: AppFonts.displaySmall.copyWith(
                  color: AppColors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<FitnessGoalModel> fitnessGoalModelList = [
    FitnessGoalModel(
      id: 0,
      title: 'Losing weight',
      format: 'Kg',
      subtitle: 'How many kg do you want to lose?',
      imagePath: 'assets/icons/loosing-weight.png',
    ),
    FitnessGoalModel(
      id: 1,
      title: 'Muscle mass gain',
      format: 'Muscle mass',
      subtitle:
          'How many kilograms do you want to increase your muscle mass by?',
      imagePath: 'assets/icons/muscle-mass.png',
    ),
    FitnessGoalModel(
      id: 2,
      title: 'Increased strength',
      format: 'Kg',
      subtitle: 'What weight do you want to achieve?',
      imagePath: 'assets/icons/increased-strength.png',
      inputTitle: 'What exercise do you want to improve?',
    ),
    FitnessGoalModel(
      id: 3,
      title: 'Improved endurance',
      format: 'Km',
      subtitle: 'What distance do you want to run/ride? (Km)',
      imagePath: 'assets/icons/improved-endurance.png',
    ),
    FitnessGoalModel(
      id: 4,
      format: null,
      title: 'Improved flexibility',
      subtitle: 'What area of flexibility do you want to improve?',
      imagePath: 'assets/icons/improved-flexibility.png',
      inputTitle: 'What area of flexibility do you want to improve?',
    ),
  ];

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
                    model.dayGoalState.currentDate ?? DateTime.now(),
                  ],
                  onChangeDate: (value) {
                    model.onUpdatedDate(value);
                  },
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
                if (model.fitnessState.isLoading)
                  const SizedBox(
                    height: 200,
                    child: Center(
                        child:
                            CircularProgressIndicator(color: AppColors.white)),
                  ),
                if (model.fitnessState.fitnessGoalList.isEmpty &&
                    !model.fitnessState.isLoading)
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
                if (model.fitnessState.fitnessGoalList.isNotEmpty &&
                    !model.fitnessState.isLoading)
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
                                    builder: (_) => FitnessGoalsAddScreen(
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
                                      onTap: () {
                                        _showBottomSheet(context, (value) {
                                          model.onUpdatedFitnessGoal(
                                            FitnessGoalModelHive(
                                                id: model.fitnessState
                                                    .fitnessGoalList[index]!.id,
                                                imagePath: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .imagePath,
                                                name: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .name,
                                                startedDate: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .startedDate,
                                                endedDate: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .endedDate,
                                                currentProgress: value,
                                                goal: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .goal,
                                                description: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .description,
                                                format: model
                                                    .fitnessState
                                                    .fitnessGoalList[index]!
                                                    .format),
                                          );
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                            model.fitnessState
                                                .fitnessGoalList[index]!,
                                            model);
                                      },
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
                                                    '${DateFormat('dd MMM').format(model.fitnessState.fitnessGoalList[index]!.startedDate)} - ${DateFormat('dd MMM yyyy').format(model.fitnessState.fitnessGoalList[index]!.endedDate)}',
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
                                                    '${model.fitnessState.fitnessGoalList[index]!.currentProgress ?? 0}/${model.fitnessState.fitnessGoalList[index]!.goal}${model.fitnessState.fitnessGoalList[index]?.format == 'Km' ? 'Km' : 'Kg'}',
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
                if (model.dayGoalState.dayGoalList.isNotEmpty &&
                    !model.dayGoalState.isLoading)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Goals for the day',
                            style: AppFonts.displayMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DayGoalAddingScreen(
                                    model: model,
                                  ),
                                ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomTextField(
                              onChange: (value) {},
                              hintText: 'Search',
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.dayGoalState.dayGoalList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.grey,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                model.dayGoalState
                                                    .dayGoalList[index]!.name,
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
                                                                DayGoalAddingScreen(
                                                              model: model,
                                                              dayGoalModel: model
                                                                  .dayGoalState
                                                                  .dayGoalList[index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      title: 'Edit',
                                                      icon:
                                                          CupertinoIcons.pencil,
                                                    ),
                                                    PullDownMenuItem(
                                                      onTap: () {
                                                        print('object');
                                                        model.onDeleteDayGoal(
                                                            model.dayGoalState
                                                                    .dayGoalList[
                                                                index]!);
                                                      },
                                                      title: 'Delete',
                                                      iconColor: Colors.red,
                                                      icon:
                                                          CupertinoIcons.delete,
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
                                          Checkbox(
                                            value: _isChecked,
                                            onChanged: _toggleCheck,
                                            checkColor: AppColors.grey,
                                            activeColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            side: const BorderSide(
                                                color: AppColors.white,
                                                width: 2),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.darkGrey,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              tagAssetsMap[model.dayGoalState
                                                  .dayGoalList[index]!.tag]!,
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              model.dayGoalState
                                                  .dayGoalList[index]!.tag,
                                              style:
                                                  AppFonts.bodySmall.copyWith(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        model.dayGoalState.dayGoalList[index]!
                                            .description,
                                        style: AppFonts.bodyMedium.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Row(
                                          children: List.generate(
                                              model
                                                  .dayGoalState
                                                  .dayGoalList[index]!
                                                  .reireration
                                                  .length, (ind) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Container(
                                                width: 25,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.primary),
                                                child: Center(
                                                  child: Text(
                                                    _getDayAbbreviation(model
                                                        .dayGoalState
                                                        .dayGoalList[index]!
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                if (model.dayGoalState.dayGoalList.isEmpty &&
                    !model.dayGoalState.isLoading)
                  _NothingWidget(
                    title: 'Goals for the day',
                    imagePath: 'assets/images/target2.png',
                    text: 'There are no goals for today',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DayGoalAddingScreen(
                                    model: model,
                                  )));
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetText extends StatefulWidget {
  final String text;
  const BottomSheetText({super.key, required this.text});

  @override
  State<BottomSheetText> createState() => _BottomSheetTextState();
}

class _BottomSheetTextState extends State<BottomSheetText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: AppFonts.bodyMedium.copyWith(
        color: AppColors.white,
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
