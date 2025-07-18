import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/routes/ongenerate_routes.dart';
import 'package:muslim_app/core/routes/routes.dart';
import 'package:muslim_app/core/theme/bloc/theme_bloc.dart';
import 'package:muslim_app/core/theme/dark_theme.dart';
import 'package:muslim_app/core/theme/light_theme.dart';
import 'package:muslim_app/core/translations/bloc/translations_bloc.dart';

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => TranslationsBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            onGenerateRoute: OngenerateRoutes.onGenerateRoute,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: state.isDarkMode ? darkTheme() : lightTheme(),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.onBoarding,
          );
        },
      ),
    );
  }
}
