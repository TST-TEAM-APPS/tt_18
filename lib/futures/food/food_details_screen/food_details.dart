import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tt_18/components/custom_button.dart';
import 'package:tt_18/components/custom_text_field.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';
import 'package:tt_18/futures/food/model/food_item_model.dart';
import 'package:tt_18/futures/food/model/food_model.dart';

class FoodDetails extends StatefulWidget {
  final FoodType? foodType;
  final Function onSave;
  final DateTime? currentDate;
  final FoodModel? model;
  const FoodDetails(
      {super.key,
      this.foodType,
      required this.onSave,
      this.currentDate,
      this.model});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  FoodType? foodType;

  String? nameOfTheFood;
  int? quantity;
  Quantity quantityType = Quantity.G;
  int? calories;
  double? proteins;
  double? fats;
  double? carbs;

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      foodType = widget.model!.typeOfFood;
      nameOfTheFood = widget.model!.name;
      quantity = widget.model!.quantity;
      quantityType = widget.model!.quantityType;
      calories = widget.model!.calories;
      carbs = widget.model!.carbs;
      proteins = widget.model!.proteins;
      fats = widget.model!.fats;
    }

    if (widget.model == null) {
      foodType = widget.foodType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Meal intake',
                style: AppFonts.displayLarge.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _FoodTypeList(
                foodType: foodType,
                onTap: (value) {
                  foodType = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Type of food',
                style: AppFonts.displaySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Name of the food',
                initialValue: nameOfTheFood,
                onChange: (value) {
                  nameOfTheFood = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Quantity',
                style: AppFonts.displaySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: '0',
                      initialValue: quantity?.toString(),
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        quantity = int.tryParse(value);
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'select',
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items:
                          List.generate(dropDownModelList.length, (int index) {
                        return DropdownMenuItem(
                            value: dropDownModelList[index]
                                .quantity
                                .toString()
                                .split('.')
                                .last,
                            child: Text(
                              dropDownModelList[index]
                                  .quantity
                                  .toString()
                                  .split('.')
                                  .last,
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                            ));
                      }),
                      value: quantityType.toString().split('.').last,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            quantityType = stringToEnum(value);
                          }
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: AppColors.grey,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: Transform.rotate(
                          angle: 3.14159 / 2,
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                        ),
                        iconSize: 20,
                        iconEnabledColor: AppColors.background,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        offset: const Offset(0, 50),
                        elevation: 0,
                        scrollbarTheme: const ScrollbarThemeData(
                            thumbColor:
                                WidgetStatePropertyAll(AppColors.background)),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.grey,
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Calories',
                style: AppFonts.displaySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: '0',
                initialValue: calories?.toString(),
                keyboardType: TextInputType.number,
                onChange: (value) {
                  calories = int.tryParse(value);
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Proteins',
                style: AppFonts.displaySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: '0',
                initialValue: proteins?.toString(),
                keyboardType: TextInputType.number,
                onChange: (value) {
                  proteins = double.tryParse(value);
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Fats',
                style: AppFonts.displaySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: '0',
                initialValue: fats?.toString(),
                keyboardType: TextInputType.number,
                onChange: (value) {
                  fats = double.tryParse(value);
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Carbs',
                style: AppFonts.displaySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: '0',
                initialValue: carbs?.toString(),
                keyboardType: TextInputType.number,
                onChange: (value) {
                  carbs = double.tryParse(value);
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.transparent,
                child: Container(
                    color: Colors.transparent,
                    height: 95,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: CustomButton(
                      title: widget.model == null ? 'Save' : 'Edit',
                      borderRadius: BorderRadius.circular(20),
                      highlightColor: Colors.white.withOpacity(0.5),
                      titleStyle: AppFonts.displayMedium
                          .copyWith(color: AppColors.white),
                      onTap: () async {
                        widget.onSave(
                          widget.model == null
                              ? FoodModel(
                                  name: nameOfTheFood!,
                                  typeOfFood: foodType!,
                                  date: widget.model != null
                                      ? widget.model!.date
                                      : widget.currentDate ?? DateTime.now(),
                                  quantity: quantity!,
                                  quantityType: quantityType,
                                  calories: calories!,
                                  proteins: proteins!,
                                  fats: fats!,
                                  carbs: carbs!,
                                )
                              : widget.model!.copyWith(
                                  name: nameOfTheFood!,
                                  typeOfFood: foodType!,
                                  date: widget.model != null
                                      ? widget.model!.date
                                      : widget.currentDate ?? DateTime.now(),
                                  quantity: quantity!,
                                  quantityType: quantityType,
                                  calories: calories!,
                                  proteins: proteins!,
                                  fats: fats!,
                                  carbs: carbs!,
                                ),
                        );
                        Navigator.pop(context);
                      },
                      isValid: nameOfTheFood != null &&
                          nameOfTheFood != '' &&
                          quantity != null &&
                          proteins != null &&
                          fats != null &&
                          carbs != null,
                      backgroundColor: AppColors.primary,
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Quantity stringToEnum(String value) {
    return Quantity.values.firstWhere(
      (e) => e.toString().split('.').last == value,
    );
  }
}

class _FoodTypeList extends StatefulWidget {
  final FoodType? foodType;
  final Function onTap;
  const _FoodTypeList({required this.foodType, required this.onTap});

  @override
  State<_FoodTypeList> createState() => __FoodTypeListState();
}

class __FoodTypeListState extends State<_FoodTypeList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: foodItemList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.onTap(foodItemList[index].type);
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.foodType == foodItemList[index].type
                          ? AppColors.primary
                          : AppColors.background,
                    ),
                    child: Center(
                      child: Image.asset(
                        foodItemList[index].imageath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    foodItemList[index].title,
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 20,
          );
        },
      ),
    );
  }
}
