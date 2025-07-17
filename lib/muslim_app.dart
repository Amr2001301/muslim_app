import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/theme/bloc/theme_bloc.dart';
import 'package:muslim_app/core/theme/dark_theme.dart';
import 'package:muslim_app/core/theme/light_theme.dart';

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ThemeBloc())],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.isDarkMode ? darkTheme() : lightTheme(),
            debugShowCheckedModeBanner: false,

            home: Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(
                      ChangeTheme(isDark: !state.isDarkMode),
                    );
                    log(state.isDarkMode.toString());
                  },
                  child: Text("Change theme"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
