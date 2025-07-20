import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_app/core/utils/app_images.dart';
import 'package:muslim_app/core/widgets/custom_text_field.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.hintKey,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
  });
  final String? hintKey;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintKey: hintKey,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      controller: controller,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(AppImages.quranBoldIcon),
      ),
    );
  }
}
