
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

double get screenWidth => ScreenUtil().screenWidth;
double get screenHeight => ScreenUtil().screenHeight;
double screen_width(double _per) => screenWidth * _per;
double screen_height(double _per) => screenHeight * _per;

// UI Constants
const Color kGrey = Color(0xff344054);
const Color kGrey25 = Color(0xffEFF3F4);
const Color kGrey50 = Color(0xffF0F5FF);
const Color kGrey100 = Color(0xffF2F4F7);
const Color kGrey200 = Color(0xffEAECF0);
const Color kGrey300 = Color(0xffD0D5DD);
const Color kGrey400 = Color(0xff98A2B3);
const Color kGrey500 = Color(0xff667085);
const Color kGrey600 = Color(0xff475467);
const Color kGrey700 = Color(0xff344053);
const Color kGrey800 = Color(0xff1D2939);
const Color kGrey900 = Color(0xff101828);


const Color kGreen25 = Color(0xffD1FADF);
const Color kGreen50 = Color(0xffF6FEF9);
const Color kGreen100 = Color(0xff0D1FADF);
const Color kGreen200 = Color(0xff027A48);
const Color kGreen400 = Color(0xff0C9D2C);
const Color kGreen500 = Color(0xff12B76A);
const Color kGreen600 = Color(0xff039855);
const Color kGreen700 = Color(0xff027A48);
const Color kGreen800 = Color(0xff054F31);

const Color kPrimary25 = Color(0xFFFAFAFF);
const Color kPrimary50 = Color(0xFFF4F3FF);
const Color kPrimary100 = Color(0xFFEBE9FE);
const Color kPrimary200 = Color(0xFFD9D6FE);
const Color kPrimary300 = Color(0xFFBDB4FE);
const Color kPrimary400 = Color(0xFF9B8AFB);
const Color kPrimary500 = Color(0xFF7A5AF8);
const Color kPrimary600 = Color(0xFF6938EF);
const Color kPrimary700 = Color(0xFF5925DC);
const Color kPrimary800 = Color(0xFF4A1FB8);
const Color kPrimary900 = Color(0xFF3E1C96);

const Color kRed50 = Color(0xffFEF3F2);
const Color kRed100 = Color(0xffFECDCA);
const Color kRed700 = Color(0xffB42318);
const Color kRed600 = Color(0xffD92D20);
const Color kRed800 = Color(0xff7A271A);
const Color kRed900 = Color(0xffE34446);

const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF1E232C);


Widget RegularText(String txt, double fontSize, Color? color,
        {int maxLines = 1}) =>
    Text(
      txt,
      maxLines: 2,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
            fontSize: fontSize,
            color: color ?? kBlack,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis),
      ),
    );