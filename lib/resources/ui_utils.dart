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
          side: const BorderSide(
            color: kGrey200,
          ),
        ),
        margin: EdgeInsets.only(
            bottom: bottomMargin ?? screenHeight * .7, left: 4, right: 4),
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

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, this.title = 'Confirm'});
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 55,
          width: screenWidth * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(105, 56, 239, 1),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, this.onTap, this.title = 'Cancel'});
  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 55,
          width: screenWidth * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kGrey500,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ),
    );
  }
}
