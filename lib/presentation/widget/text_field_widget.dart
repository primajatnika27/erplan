import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  final String value;
  final InputDecoration decoration;
  final TextStyle style;
  final TextAlign textAlign;
  final VoidCallback onTap;

  TextFieldButton({
    required Key key,
    required this.value,
    this.decoration = const InputDecoration(),
    required this.style,
    this.textAlign = TextAlign.start,
    required this.onTap,
  }) : super(key: key);

  bool get _enabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = (decoration ?? const InputDecoration())
        .applyDefaults(Theme.of(context).inputDecorationTheme)
        .copyWith(
          enabled: _enabled,
        );

    final effectiveBorder =
        effectiveDecoration.border ?? const UnderlineInputBorder();

    return InkWell(
      onTap: onTap,
      customBorder: effectiveBorder,
      child: InputDecorator(
        decoration: effectiveDecoration,
        baseStyle: style,
        textAlign: textAlign,
        isFocused: false,
        isEmpty: (value == null),
        child: Text(value ?? ''),
      ),
    );
  }
}
