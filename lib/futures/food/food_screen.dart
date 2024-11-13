import 'package:flutter/cupertino.dart';
import 'package:tt_18/components/custom_current_date_widget.dart';
import 'package:tt_18/core/app_fonts.dart';
import 'package:tt_18/core/colors.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CurrentDateWIdget(),
            SizedBox(
              height: 30,
            ),
            _ProgressWidget(),
          ],
        ),
      ),
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
                        Image.asset(
                          'assets/icons/pencil-edit.png',
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        )
                      ],
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
                              '0',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            Text(
                              '0',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                            Text(
                              '0',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                          ],
                        ),
                        SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // ListView.separated(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemBuilder: (BuildContext context, int index) {
        //       return Container(
        //         height: 60,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20),
        //           color: AppColors.surface,
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Row(
        //               children: [Image.asset(''), Text('data')],
        //             ),
        //             Text('data')
        //           ],
        //         ),
        //       );
        //     },
        //     separatorBuilder: (BuildContext context, int index) {
        //       return const SizedBox(
        //         height: 10,
        //       );
        //     },
        //     itemCount: itemCount)
      ],
    );
  }
}
