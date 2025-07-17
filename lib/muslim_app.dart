import 'package:flutter/material.dart';

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muslim App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Muslim App')),
        body: const Center(child: Text('Muslim App')),
      ),
    );
  }
}
