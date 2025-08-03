import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:muslim_app/core/utils/app_colors.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_audio_entity/audio_detials_entity.dart';

class CustomAudioPlayItem extends StatelessWidget {
  const CustomAudioPlayItem({super.key, required this.audios});
  final List<AudioDetialsEntity> audios;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu(
          initialSelection: 1,
          onSelected: (value) {
            log(value.toString());
          },
          dropdownMenuEntries: List.generate(
            5,
            (index) => DropdownMenuEntry(
              value: index,
              label: audios[index].reciter ?? '',
            ),
          ),
        ),
        verticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.volume_up_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.skip_next_rounded)),
            horizontalSpace(5),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.goldDarkColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pause_rounded,
                color: AppColors.blackColor,
              ),
            ),
            horizontalSpace(5),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.skip_previous_rounded),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.speed)),
          ],
        ),
        Slider(
          min: 0,
          max: 10,
          activeColor: AppColors.goldLightColor,
          inactiveColor: AppColors.gery600,
          value: 2,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
