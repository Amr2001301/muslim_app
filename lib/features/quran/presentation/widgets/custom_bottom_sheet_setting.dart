import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/core/widgets/custom_botton_sheet.dart';
import 'package:muslim_app/features/quran/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:muslim_app/features/quran/presentation/widgets/custom_bottom_sheet_botton.dart';
import 'package:muslim_app/features/quran/presentation/widgets/custom_font_size_slider.dart';

class CustomBottomSheetSetting extends StatelessWidget {
  const CustomBottomSheetSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppConst.kSmallPadding),
      height: 74,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBottomSheetBotton(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    CustomBottonSheet(child: CustomFontSizeSlider()),
              );
            },
            title: 'fontSize',
            icon: Icons.font_download,
          ),
          CustomBottomSheetBotton(
            onTap: () {
              context.read<SettingCubit>().startAnimatioScroll(50);
            },
            title: 'AutomaticAnimation',
            icon: Icons.keyboard_double_arrow_down_rounded,
          ),
          CustomBottomSheetBotton(
            title: 'soundPlay',
            icon: Icons.play_arrow_rounded,
          ),
        ],
      ),
    );
  }
}
