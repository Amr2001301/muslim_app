import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_app/core/service/service_locator.dart';
import 'package:muslim_app/features/dashboard/presentation/widgets/custom_nav_bar.dart';
import 'package:muslim_app/features/quran/domain/repo/quran_repo.dart';
import 'package:muslim_app/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:muslim_app/features/quran/presentation/screen/quran_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PersistentTabController _controller;
  List<CustomNavBarScreen> screens = [
    CustomNavBarScreen(
      screen: BlocProvider(
        create: (context) => QuranCubit(getIt<QuranRepo>())..getAllSura(),
        child: QuranScreen(),
      ),
    ),
    CustomNavBarScreen(screen: SizedBox()),
    CustomNavBarScreen(screen: SizedBox()),
    CustomNavBarScreen(screen: SizedBox()),
    CustomNavBarScreen(screen: SizedBox()),
  ];
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView.custom(
        controller: _controller,
        navBarHeight: 80.h,
        bottomScreenMargin: 0,
        confineToSafeArea: false,
        backgroundColor: Colors.transparent,
        context,
        customWidget: CustomNavBar(
          currentIndex: _controller.index,
          onTap: (int index) {
            setState(() {
              _controller.index = index;
            });
          },
        ),
        itemCount: screens.length,
        screens: screens,
      ),
    );
  }
}
