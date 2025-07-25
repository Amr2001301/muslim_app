import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/utils/app_colors.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit.dart';

class CustomFontSizeSlider extends StatelessWidget {
  const CustomFontSizeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        if (state is ChangeFontSize) {
          return Slider(
            divisions: 32,
            activeColor: AppColors.goldDarkColor,
            inactiveColor: AppColors.gery600,
            max: 42,
            min: 10,
            value: context.read<QuranCubit>().fontSize,
            onChanged: (value) {
              context.read<QuranCubit>().changeFontSized(value);
            },
          );
        } else {
          return Slider(
            divisions: 32,
            activeColor: AppColors.goldDarkColor,
            inactiveColor: AppColors.gery600,
            max: 42,
            min: 10,
            value: context.read<QuranCubit>().fontSize,
            onChanged: (value) {},
          );
        }
      },
    );
  }
}
