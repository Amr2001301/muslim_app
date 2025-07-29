import 'package:flutter/material.dart';

class CustomAudioPlayItem extends StatelessWidget {
  const CustomAudioPlayItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.pause_rounded),
        const Icon(Icons.play_arrow_rounded),
      ],
    );
  }
}
