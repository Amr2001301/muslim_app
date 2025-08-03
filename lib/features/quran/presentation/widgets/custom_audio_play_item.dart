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
  bool isVolume = true;
  double speed = 1;

  @override
  Widget build(BuildContext context) {
    final audioService = AudioService();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownMenu(
            initialSelection: 0,
            onSelected: (value) {
              setState(() {
                initialValue = value!;
                log(widget.audios[value].reciter!);
              });
              audioService.stop();
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
                  horizontalSpace(5),
                  IconButton(
                    onPressed: () async {
                      if (isVolume) {
                        await audioService.setVolume(0);
                        isVolume = false;
                        setState(() {});
                      } else {
                        await audioService.setVolume(1);
                        isVolume = true;
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      isVolume
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final currentPosition =
                          await audioService.onPositionChanged!.first;
                      final newPosition =
                          currentPosition - const Duration(seconds: 10);
                      await audioService.seek(newPosition);
                    },
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
                    onPressed: () async {
                      final currentPosition =
                          await audioService.onPositionChanged!.first;
                      final newPosition =
                          currentPosition + const Duration(seconds: 10);
                      await audioService.seek(newPosition);
                    },
                    icon: const Icon(Icons.skip_previous_rounded),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (speed == 1) {
                        await audioService.setSpeed(1.5);
                        setState(() {
                          speed = 1.5;
                        });
                      } else if (speed == 1.5) {
                        await audioService.setSpeed(2);
                        setState(() {
                          speed = 2;
                        });
                      } else if (speed == 2) {
                        await audioService.setSpeed(0.5);
                        setState(() {
                          speed = 0.5;
                        });
                      } else if (speed == 0.5) {
                        await audioService.setSpeed(1);
                        setState(() {
                          speed = 1;
                        });
                      }
                    },
                    icon: Row(
                      children: [
                        const Icon(Icons.speed),
                        horizontalSpace(5),
                        Text('$speed'),
                      ],
                    ),
                  ),
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
