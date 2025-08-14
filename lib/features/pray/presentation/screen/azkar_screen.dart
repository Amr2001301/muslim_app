import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/core/service/service_locator.dart';
import 'package:muslim_app/features/pray/domain/repo/azkar_repo.dart';
import 'package:muslim_app/features/pray/presentation/cubit/azkar_cubit/azkar_cubit.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key, required this.azkarName});
  final String azkarName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AzkarCubit(getIt<AzkarRepo>()..getAzkar(azkarName: azkarName)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            azkarName == "azkar_sabah"
                ? 'azkar_morning'.tr()
                : 'azkar_evening'.tr(),
          ),
        ),
        body: BlocConsumer<AzkarCubit, AzkarState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column();
          },
        ),
      ),
    );
  }
}
