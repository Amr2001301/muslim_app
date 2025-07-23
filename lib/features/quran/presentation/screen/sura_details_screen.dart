import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/utils/app_styles.dart';
import 'package:muslim_app/core/widgets/custom_loading_app.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:muslim_app/features/quran/presentation/widgets/cusrom_sura_page.dart';

class SuraDetailsScreen extends StatelessWidget {
  const SuraDetailsScreen({super.key, required this.suraEntity});
  final SuraEntity suraEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(suraEntity.name)),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is GetSuraByIndexSuccess) {
            final ayahs = state.sura.ayahs ?? [];
            final pages = ayahs.map((e) => e.page).toSet().toList()..sort();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ',
                    style: AppStyles.style16SemiBold,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return CustomSuraPage(pageNumber: pages[index]!);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const CustomLoadingApp();
          }
        },
      ),
    );
  }
}
