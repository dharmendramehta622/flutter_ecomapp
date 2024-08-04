
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';

void showSnackBarMessage(BuildContext context, Widget widget,
    {int duration = 5, double? bottomMargin}) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.vertical,
        // width: screenWidth,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12), // Adjust the border radius as needed
          side:const BorderSide(
            color: kGrey200,
          ),
        ),
        margin: EdgeInsets.only(bottom: bottomMargin ??  screenHeight * .7, left: 4, right: 4),
        backgroundColor: kWhite,
        content: widget,
        duration: Duration(seconds: duration),
      ),
    );
  });
}

void showMessage(String message) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: kBlack,
        textColor: Colors.white,
        fontSize: 16.0);
  });
}

void showSuccessMessage(String message) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: kGreen700,
        textColor: kWhite,
        fontSize: 16.0);
  });
}

void showErrorMessage(String message) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: kWhite,
        fontSize: 16.0);
  });
}
