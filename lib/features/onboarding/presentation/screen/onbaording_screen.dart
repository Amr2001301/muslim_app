import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/utils/app_colors.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/core/utils/app_styles.dart';
import 'package:muslim_app/features/onboarding/data/model/onboarding_model.dart';
import 'package:muslim_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:muslim_app/features/onboarding/presentation/widgets/custom_page_view.dart';

class OnbaordingScreen extends StatelessWidget {
  const OnbaordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConst.kDefaultPadding,
          ),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final cubit = context.read<OnboardingCubit>();
              final onboardingList = OnboardingModel.getOnBoardingList();

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: cubit.onPageChanged,
                      controller: cubit.pageController,
                      itemCount: onboardingList.length,
                      itemBuilder: (context, index) {
                        return CustomPageView(
                          onboardingModel: onboardingList[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppConst.kDefaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (cubit.currentPage > 0)
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          onPressed: cubit.previousPage,
                          child: Text(
                            'previous'.tr(),
                            style: AppStyles.style13SemiBold.copyWith(
                              color: AppColors.goldDarkColor,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 64), // مساحة تعويضية

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          onboardingList.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 5,
                            width: cubit.currentPage == index ? 25 : 5,
                            decoration: BoxDecoration(
                              color: cubit.currentPage == index
                                  ? AppColors.goldDarkColor
                                  : AppColors.gery600,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),

                      if (cubit.currentPage < onboardingList.length - 1)
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          onPressed: cubit.nextPage,
                          child: Text(
                            'next'.tr(),
                            style: AppStyles.style13SemiBold.copyWith(
                              color: AppColors.goldDarkColor,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 64),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
