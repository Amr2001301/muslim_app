import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/core/utils/app_styles.dart';

class CustomBottomSheetBotton extends StatelessWidget {
  const CustomBottomSheetBotton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon),
          verticalSpace(5),
          Text(title.tr(), style: AppStyles.style12Regular),
        ],
      ),
    );
  }
}
