import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:muslim_app/core/service/audio_services.dart';
import 'package:muslim_app/core/utils/app_colors.dart';
import 'package:muslim_app/core/utils/app_const.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_audio_entity/audio_detials_entity.dart';

class CustomAudioPlayItem extends StatefulWidget {
  const CustomAudioPlayItem({
    super.key,
    required this.audios,
    required this.suraIndex,
  });
  final List<AudioDetialsEntity> audios;
  final int suraIndex;

  @override
  State<CustomAudioPlayItem> createState() => _CustomAudioPlayItemState();
}

class _CustomAudioPlayItemState extends State<CustomAudioPlayItem> {
  int initialValue = 1;

  @override
  Widget build(BuildContext context) {
    final audioService = AudioService();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownMenu(
            initialSelection: 1,
            onSelected: (value) {
              setState(() {
                initialValue = value!;
                log(widget.audios[value].reciter!);
              });
            },
            dropdownMenuEntries: List.generate(
              widget.audios.length,
              (index) => DropdownMenuEntry(
                value: index,
                label: widget.audios[index].reciter ?? '',
              ),
            ),
          ),
          verticalSpace(16),
          StreamBuilder<PlayerState>(
            stream: audioService.onPlayerStateChanged ?? const Stream.empty(),
            initialData: PlayerState.stopped,
            builder: (context, asyncSnapshot) {
              final state = asyncSnapshot.data ?? PlayerState.stopped;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded),
                  ),
                  horizontalSpace(5),
                  GestureDetector(
                    onTap: () async {
                      log('state: $state');
                      if (state == PlayerState.playing) {
                        await audioService.pause();
                      } else if (state == PlayerState.paused) {
                        await audioService.resume();
                      } else if (state == PlayerState.stopped) {
                        await audioService.play(
                          widget.audios[initialValue].originalUrl ?? '',
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.goldDarkColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getIconForPlayerState(state),
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  horizontalSpace(5),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous_rounded),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.speed)),
                ],
              );
            },
          ),

          StreamBuilder<Duration>(
            stream: audioService.onPositionChanged ?? const Stream.empty(),
            builder: (context, positionSnapshot) {
              return StreamBuilder<Duration>(
                stream: audioService.onDurationChanged ?? const Stream.empty(),

                builder: (context, durationSnapshot) {
                  final position = positionSnapshot.data ?? Duration.zero;
                  final total =
                      durationSnapshot.data ?? const Duration(seconds: 1);

                  return Column(
                    children: [
                      Slider(
                        min: 0,
                        max: total.inMilliseconds.toDouble(),
                        value: position.inMilliseconds
                            .clamp(0, total.inMilliseconds)
                            .toDouble(),
                        activeColor: AppColors.goldLightColor,
                        inactiveColor: AppColors.gery600,
                        onChanged: (value) {
                          audioService.seek(
                            Duration(milliseconds: value.toInt()),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(position)),
                          Text(_formatDuration(total)),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getIconForPlayerState(PlayerState? state) {
    switch (state) {
      case PlayerState.playing:
        return Icons.pause;
      case PlayerState.paused:
      case PlayerState.stopped:
      default:
        return Icons.play_arrow;
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
