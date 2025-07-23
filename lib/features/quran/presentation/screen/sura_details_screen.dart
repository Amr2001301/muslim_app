import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/translations/bloc/translations_bloc.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/core/widgets/custom_loading_app.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit.dart';

class SuraDetailsScreen extends StatelessWidget {
  const SuraDetailsScreen({super.key, required this.suraEntity});
  final SuraEntity suraEntity;

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.watch<TranslationsBloc>().state.isArabic;
    return Scaffold(
      appBar: AppBar(
        title: Text(!isArabic ? suraEntity.englishName : suraEntity.name),
      ),
      body: BlocConsumer<QuranCubit, QuranState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GetSuraByIndexLoading) {
            return CustomLoadingApp();
          } else if (state is GetSuraByIndexSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConst.kDefaultPadding,
                vertical: AppConst.kDefaultPadding,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
