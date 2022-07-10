import 'package:flutter/material.dart';
import '../../extension/context_extension.dart';
import '../../config/style_config.dart';

class PasswordTextFormFieldWidget extends StatefulWidget {
  @override
  _PasswordTextFormFieldWidgetState createState() =>
      _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState
    extends State<PasswordTextFormFieldWidget> {
  late bool _isInVisible;

  @override
  void initState() {
    _isInVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isInVisible,
      style: context.textTheme.bodyText2!.copyWith(
        color: AppColor.PRIMARY,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        isDense: true,
        border: OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isInVisible = !_isInVisible;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              _isInVisible
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye,
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 10),
      ),
    );
  }
}
