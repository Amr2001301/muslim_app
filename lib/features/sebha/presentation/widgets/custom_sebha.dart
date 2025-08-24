import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/core/utils/app_images.dart';
import 'package:muslim_app/core/utils/app_styles.dart';

class CustomSebha extends StatelessWidget {
  const CustomSebha({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppImages.sebha),
        PositionedDirectional(
          top: 80,
          start: 0,
          end: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('1/33', style: AppStyles.style20Bold),
              verticalSpace(16),
              Text('${'num_of_round'.tr()} : 30', style: AppStyles.style20Bold),
            ],
          ),
        ),
      ],
    );
  }
}
