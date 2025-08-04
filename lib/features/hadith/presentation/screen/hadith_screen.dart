import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/service/service_locator.dart';
import 'package:muslim_app/features/hadith/data/repo/hadith_repo.dart';
import 'package:muslim_app/features/hadith/presentation/cubit/hadith_cubit.dart';
import 'package:muslim_app/features/hadith/presentation/widgets/hadith_screen_body.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadithCubit(getIt.get<HadithRepo>())..getAllHadith(),
      child: HadithScreenBody(),
    );
  }
}
