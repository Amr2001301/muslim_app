import 'package:flutter/material.dart';
import 'package:muslim_app/core/utils/app_const.dart';

class CustomBottonSheet extends StatelessWidget {
  const CustomBottonSheet({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(AppConst.kDefaultPadding),
        child: child,
      ),
    );
  }
}
