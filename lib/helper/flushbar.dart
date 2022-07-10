import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/style_config.dart';

Flushbar showFlushbar(BuildContext context, String message,
    {bool isTopPosition = false,
    dynamic thenEvent,
    bool isError = true,
    bool forTradeValidation = false}) {
  return Flushbar(
    // message: message,
    messageText: Text(
      message,
      textAlign: TextAlign.center,
    ),
    titleSize: 16,
    messageSize: 14,
    backgroundColor: forTradeValidation
        ? AppColor.ERROR
        : Theme.of(context).dialogBackgroundColor.withOpacity(0.8),
    flushbarPosition:
        isTopPosition ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    margin: forTradeValidation
        ? EdgeInsets.only(bottom: 62.h)
        : EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 80),
    padding: forTradeValidation
        ? EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 13.h,
          ).copyWith(bottom: 9.h)
        : EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
    borderRadius: forTradeValidation
        ? BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          )
        : BorderRadius.circular(8),
    isDismissible: false,
    animationDuration: Duration(milliseconds: 500),
    duration: Duration(seconds: 3),
  )..show(context).then((_) => thenEvent);
}
