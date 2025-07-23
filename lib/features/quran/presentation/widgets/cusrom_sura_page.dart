import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/utils/app_colors.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/core/utils/app_styles.dart';
import 'package:muslim_app/core/utils/functions/remove_basmala.dart';
import 'package:muslim_app/features/quran/domain/entity/ayah_entity.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit.dart';

class CustomSuraPage extends StatelessWidget {
  final int pageNumber;
  const CustomSuraPage({super.key, required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        if (state is GetSuraByIndexSuccess) {
          List<AyahEntity> ayahs = state.sura.ayahs!
              .where((e) => e.page == pageNumber)
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConst.kDefaultPadding),
                child: Text.rich(
                  TextSpan(
                    children: ayahs.map((ayah) {
                      return TextSpan(
                        children: [
                          TextSpan(
                            text: removeBasmalah(ayah.text!),
                            style: AppStyles.style18Regular,
                          ),
                          TextSpan(
                            text: " ﴿${ayah.numberInSurah}﴾ ",
                            style: AppStyles.style16SemiBold.copyWith(
                              color: AppColors.goldDarkColor,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          height: 2,
                        ),
                      );
                    }).toList(),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Center(
                child: Text("$pageNumber", style: AppStyles.style13SemiBold),
              ),
              const Divider(height: 32, thickness: 4, color: Colors.black),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
