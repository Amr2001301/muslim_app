import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/utils/app_colors.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit.dart';

class CustomFontSizeSlider extends StatefulWidget {
  const CustomFontSizeSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomFontSizeSliderState createState() => _CustomFontSizeSliderState();
}

class _CustomFontSizeSliderState extends State<CustomFontSizeSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          value: context.read<QuranCubit>().fontSized.value,
          min: 10.0,
          max: 42.0,
          divisions: 32,
          activeColor: AppColors.goldDarkColor,
          inactiveColor: AppColors.gery200,
          label: context.read<QuranCubit>().fontSized.value.toString(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
