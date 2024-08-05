import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_project/Networks/models/clockin_model.dart';
import 'package:new_project/resources/constants.dart';
import 'package:new_project/resources/utils.dart';
import 'package:new_project/utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.e});

  final ClockInModel e;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
        border: Border(
          bottom: BorderSide(
            color: kGrey200, // Set the border color
            width: 2.0, // Set the border width
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 54,
              width: 54,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: kPrimary50),
              child: Column(
                children: [
                  BoldText('12', 16, kBlack),
                  BoldText('MON', 10, kBlack),
                ],
              ),
            ),
            const Gap(4), 
            BoldText(e.checkIn!.customTimeFormat, 14, kBlack), 
            const Gap(4), 
            BoldText(
                e.checkOut == null
                    ? '        -        '
                    : e.checkOut!.customTimeFormat,
                14,
                kBlack), 
            const Gap(4), 
            Container(
              height: 30,
              width: 90,
              padding:
                  const EdgeInsets.only(top: 4, right: 10, bottom: 4, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.greyColor),
              child: Row(
                children: [
                  Image.asset('assets/icons/check.png'),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text(
                    'Present',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(2, 122, 72, 1)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
