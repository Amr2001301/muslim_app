import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_app/core/routes/routes.dart';
import 'package:muslim_app/core/utils/app_images.dart';
import 'package:muslim_app/core/utils/app_styles.dart';
import 'package:muslim_app/core/utils/extention/navigator_extention.dart';
import 'package:muslim_app/features/quran/domain/entity/sura_entity.dart';

class CustomSuraItem extends StatelessWidget {
  const CustomSuraItem({super.key, required this.suraEntity});
  final SuraEntity suraEntity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(Routes.sura, arguments: suraEntity);
      },
      contentPadding: EdgeInsets.all(0),
      title: Text(suraEntity.name, style: AppStyles.style16Bold),
      subtitle: Text(
        '${suraEntity.numberOfAyahs}'
                'verses'
            .tr(),
        style: AppStyles.style13SemiBold,
      ),
      trailing: Text(suraEntity.englishName, style: AppStyles.style16Bold),
      leading: Stack(
        children: [
          SvgPicture.asset(AppImages.suraNumber, width: 48, height: 48),
          PositionedDirectional(
            top: 0,
            bottom: 0,
            end: 0,
            start: 0,
            child: Center(
              child: Text(
                (suraEntity.number).toString(),
                style: AppStyles.style10SemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
