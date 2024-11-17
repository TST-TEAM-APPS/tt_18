import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/components/custom_text_field.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/food/food_details_screen/food_details.dart';
import 'package:tt_18/futures/food/model/food_item_model.dart';
import 'package:tt_18/futures/food/model/food_model.dart';
import 'package:tt_18/futures/home/home_screen.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CurrentDateWIdget(
              value: [
                context.watch<FoodViewModel>().state.currentDateTime ??
                    DateTime.now(),
              ],
              onChangeDate: (DateTime value) {
                context.read<FoodViewModel>().onUpdatedDate(value);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const _ProgressWidget(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _FoodItemCardWidget(
                  id: 0,
                  model: context
                      .select((FoodViewModel vm) => vm.state.foodBreakfestList),
                ),
                const SizedBox(
                  height: 10,
                ),
                _FoodItemCardWidget(
                  id: 1,
                  model: context
                      .select((FoodViewModel vm) => vm.state.foodLunchList),
                ),
                const SizedBox(
                  height: 10,
                ),
                _FoodItemCardWidget(
                  id: 2,
                  model: context
                      .select((FoodViewModel vm) => vm.state.foodSnakList),
                ),
                const SizedBox(
                  height: 10,
                ),
                _FoodItemCardWidget(
                  id: 3,
                  model: context
                      .select((FoodViewModel vm) => vm.state.foodDinnerList),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodItemCardWidget extends StatelessWidget {
  final int id;
  final List<FoodModel?>? model;

  const _FoodItemCardWidget({
    required this.id,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => FoodDetails(
                          currentDate: context
                              .read<FoodViewModel>()
                              .state
                              .currentDateTime!,
                          onSave: (value) {
                            context
                                .read<FoodViewModel>()
                                .onFoodItemAdded(value);
                          },
                          foodType: foodItemList[id].type)));
            },
            highlightColor: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(foodItemList[id].imageath),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        foodItemList[id].title,
                        style: AppFonts.displaySmall
                            .copyWith(color: AppColors.white),
                      )
                    ],
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
        ),
        const SizedBox(
          height: 10,
        ),
        _FoodListWidget(
          model: model,
        )
      ],
    );
  }
}

class _FoodListWidget extends StatelessWidget {
  final List<FoodModel?>? model;
  const _FoodListWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model![index]!.name.toString(),
                      style: AppFonts.displaySmall
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(
                      width: 10,
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
                                  builder: (_) => FoodDetails(
                                    onSave: (value) {
                                      context
                                          .read<FoodViewModel>()
                                          .onUpdatedFood(value);
                                    },
                                    model: model![index],
                                  ),
                                ),
                              );
                            },
                            title: 'Edit',
                            icon: CupertinoIcons.pencil,
                          ),
                          PullDownMenuItem(
                            onTap: () {
                              context
                                  .read<FoodViewModel>()
                                  .onDeleteFood(model![index]!);
                            },
                            title: 'Delete',
                            iconColor: Colors.red,
                            icon: CupertinoIcons.delete,
                          ),
                        ],
                        buttonBuilder: (context, showMenu) => CupertinoButton(
                            onPressed: showMenu,
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              'assets/icons/dots.png',
                              width: 14,
                              height: 2,
                              fit: BoxFit.cover,
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        '${model![index]!.quantity} ${model![index]!.quantityType.toString().split('.').last}',
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${model![index]!.calories} Kcal',
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${model![index]!.proteins} (P)',
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${model![index]!.fats} (F)',
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${model![index]!.carbs} (C)',
                        style: AppFonts.bodyMedium
                            .copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: model?.length ?? 0);
  }
}

class _ProgressWidget extends StatelessWidget {
  const _ProgressWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();
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
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Calories',
                          style: AppFonts.displaySmall
                              .copyWith(color: AppColors.onPrimary),
                        ),
                        GestureDetector(
                          onTap: () {
                            int? number;
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: AppColors.primary,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Your ideal daily calorie intake?',
                                            style: AppFonts.displayMedium
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            onChange: (value) {
                                              number = int.tryParse(value);
                                            },
                                            hintText: '0',
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          CustomButton(
                                            title: 'Save',
                                            titleStyle:
                                                AppFonts.displaySmall.copyWith(
                                              color: AppColors.white,
                                            ),
                                            onTap: () {
                                              model.onSetCalorie(number ?? 0);
                                              Navigator.pop(context);
                                            },
                                            backgroundColor: AppColors.surface,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/icons/pencil-edit.png',
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${model.state.totalCalories ?? 0}',
                              style: AppFonts.displayLarge
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            TextSpan(
                              text: '/${model.state.calorieGoal}',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                          ],
                        ),
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
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Proteins',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            Text(
                              'Fats',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            Text(
                              'Carbs',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${model.state.totalProteins ?? 0}',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            Text(
                              '${model.state.totalCarbs ?? 0}',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            Text(
                              '${model.state.totalCalories ?? 0}',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                          ],
                        ),
                        const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
