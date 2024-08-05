import 'package:flutter/material.dart';
import 'package:new_project/utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.date,
      required this.day,
      required this.checkIn,
      required this.checkOut});

  dynamic date;
  String day;
  dynamic checkIn;
  dynamic checkOut;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 47,
            width: 47,
            padding: EdgeInsets.only(top: 8, right: 12, bottom: 8, left: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.greyColor),
            child: Column(
              children: [
                Text(
                  date,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.textColor),
                ),
                Text(
                  day,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: AppColors.textColor),
                )
              ],
            ),
          ),
          Text(
            checkIn,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.textColor,
              letterSpacing: -1,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.textColor,
              letterSpacing: -1,
            ),
          ),
          Container(
            height: 30,
            width: 90,
            padding: EdgeInsets.only(top: 4, right: 10, bottom: 4, left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.greyColor),
            child: Row(
              children: [
                Image.asset('assets/icons/check.png'),
                SizedBox(
                  width: 3,
                ),
                Text(
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
    );
  }
}
