import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/style_config.dart';

class OutlineTextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool obscureText;

  OutlineTextFormFieldWidget({
    this.hintText = '',
    this.validator,
    this.controller,
    this.obscureText = false,
  });

  @override
  _OutlineTextFormFieldWidgetState createState() =>
      _OutlineTextFormFieldWidgetState();
}

class _OutlineTextFormFieldWidgetState
    extends State<OutlineTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.ERROR,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        errorStyle: TextStyle(
          color: AppColor.ERROR,
          fontSize: 14.sp,
        ),
        errorMaxLines: 1,
        hintStyle: TextStyle(
          color: Theme.of(context).canvasColor.withOpacity(0.6),
          fontSize: 14.sp,
        ),
      ),
      validator: widget.validator,
    );
  }
}
