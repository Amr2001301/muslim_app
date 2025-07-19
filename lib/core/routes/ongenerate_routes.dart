import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/routes/routes.dart';
import 'package:muslim_app/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:muslim_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:muslim_app/features/onboarding/presentation/screen/onbaording_screen.dart';

abstract class OngenerateRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OnboardingCubit(),
            child: const OnbaordingScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
