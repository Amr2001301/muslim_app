import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/widgets/custom_loading_app.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:muslim_app/features/quran/presentation/widgets/custom_audio_play_item.dart';

class SoundAudioBottomSheet extends StatelessWidget {
  const SoundAudioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        if (state is GetSuraAudioSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [CustomAudioPlayItem(), Text('data')],
          );
        } else if (state is GetSuraAudioLoading) {
          return CustomLoadingApp();
        } else {
          return Container();
        }
      },
    );
  }
}
