import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/provider/user_provider.dart';
import 'package:healthyou_app/widget/home/profile/edit_info_dialog.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../global/rounded_button_medium.dart';
import 'degreement_sylinder.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  void editInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => EditInfoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            width: double.maxFinite,
            height: 520 * getScaleFactorFromHeight(context),
            child: Column(
              children: [
                achievementDaysHelper(context),
                infoDetailHelper(context),
                achieveGraphHelper(context),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RoundedButtonMedium(
                      text: "정보 수정",
                      onPressEvent: () => editInfo(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '전문적인 지식을 가지고 만든 어플이 아닌 점 양해 부탁드리며 추가 되었으면 하는 기능, 정보, 자료 등등 아래 이메일로 작성해서 보내주시면 검토후에 적용 하겠습니다.\n\nrkdalsdl98@naver.com',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      fontSize: 8 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget achieveGraphHelper(BuildContext context) {
    return Container(
      width: 263 * getScaleFactorFromWidth(context),
      height: 140 * getScaleFactorFromHeight(context),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(.25),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Consumer<TraningProvider>(
          builder: (_, provider, __) {
            final schedules = provider.schedules;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var schedule in schedules.values)
                  DegreementSylinder(schedule: schedule)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget infoDetailHelper(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      final info = provider.info;
      return Container(
        width: 263 * getScaleFactorFromWidth(context),
        height: 58 * getScaleFactorFromHeight(context),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 4),
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(.25),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              height: 28 * getScaleFactorFromHeight(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  profileTextHelper(context, "체중",
                      mainText: "${info!.weight}", unitText: "kg"),
                  profileTextHelper(context, "키",
                      mainText: "${info.height}", unitText: "cm"),
                  profileTextHelper(context, "골격근량",
                      mainText: "${info.skeletalMuscle}", unitText: "kg"),
                  profileTextHelper(context, "체지방량",
                      mainText: "${info.bodyFat}", unitText: "kg"),
                  profileTextHelper(
                    context,
                    "체지방률",
                    mainText: "${info.bodyFatPercent}",
                    unitText: "%",
                  ),
                  profileTextHelper(
                    context,
                    "BMI",
                    mainText: "${info.bmi}",
                    unitText: "kg/㎡",
                  ),
                  profileTextHelper(
                    context,
                    "기초 대사량",
                    mainText: "${info.basalMetabolicRate}",
                    unitText: "kcal",
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

Widget achievementDaysHelper(BuildContext context) {
  return Container(
    width: 200 * getScaleFactorFromWidth(context),
    height: 200 * getScaleFactorFromWidth(context),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(180),
      border: Border.all(
        width: 5,
        color: Theme.of(context).colorScheme.outline,
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          offset: const Offset(0, 4),
          color:
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(.25),
        ),
      ],
    ),
    child: Center(
      child: Consumer<TraningProvider>(builder: (_, provider, __) {
        final achievementDays = provider.achievementDays;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 38 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w800,
                height: 1.5,
              ),
              text: '${achievementDays ?? 0} 일\n',
              children: [
                TextSpan(
                  text: '설정한 목표를 이행한지\n이만큼이나 되었어요!',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12 * getScaleFactorFromWidth(context),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    ),
  );
}

Widget profileTextHelper(
  BuildContext context,
  String categoryText, {
  String? mainText,
  String? unitText,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        categoryText,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 8 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: mainText == "null" ? "모름" : "$mainText\n",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 8 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          children: [
            if (mainText != "null")
              TextSpan(
                text: unitText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 4 * getScaleFactorFromWidth(context),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
