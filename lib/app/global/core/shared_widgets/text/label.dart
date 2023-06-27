import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

enum TextType {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  title,
  subtitle,
  text,
  button,
  caption,
  labelLarge,
  labelMedium,
  labelSmall,
}

enum TextWeight {
  bold,
  semiBold,
  regular,
  semiLigth,
  ligth,
}

class Label extends StatelessWidget {
  const Label(
    this.data, {
    Key? key,
    this.maxLines,
    this.color,
    this.underline = false,
    this.idCrossed = false,
    this.truncate = false,
    this.textType = TextType.text,
    this.textAlign = TextAlign.left,
    this.textWeight = TextWeight.regular,
  }) : super(key: key);

  final String data;
  final int? maxLines;
  final bool truncate;
  final bool underline;
  final bool idCrossed;
  final Color? color;
  final TextType textType;
  final TextAlign textAlign;
  final TextWeight textWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? S2BColors.black,
        fontFamily: 'Poppins',
        fontSize: _getFontSize(textType),
        fontWeight: _getFontWeight(textWeight),
        letterSpacing: 0.3,
        decoration: underline
            ? TextDecoration.underline
            : idCrossed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        decorationColor: color,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 1.7,
      ),
      textScaleFactor: 1,
      maxLines: maxLines,
      overflow: truncate ? TextOverflow.ellipsis : null,
      softWrap: true,
    );
  }

  static TextStyle textStyle(
    BuildContext context, {
    int? maxLines,
    bool truncate = false,
    bool underline = false,
    bool idCrossed = false,
    Color? color,
    TextType textType = TextType.text,
    TextAlign textAlign = TextAlign.left,
    TextWeight textWeight = TextWeight.regular,
  }) {
    return TextStyle(
      color: color ?? S2BColors.black,
      fontFamily: 'Poppins',
      fontSize: _getFontSize(textType),
      fontWeight: _getFontWeight(textWeight),
      letterSpacing: 0.3,
      decoration: underline
          ? TextDecoration.underline
          : idCrossed
              ? TextDecoration.lineThrough
              : TextDecoration.none,
      decorationColor: color,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 1.7,
    );
  }

  static double _getFontSize(TextType typeLabel) {
    switch (typeLabel) {
      case TextType.h1:
        return 32;
      case TextType.h2:
        return 28;
      case TextType.h3:
        return 18;
      case TextType.h4:
        return 16;
      case TextType.h5:
        return 14;
      case TextType.h6:
        return 13;
      case TextType.title:
        return 23;
      case TextType.subtitle:
        return 19;
      case TextType.text:
        return 13;
      case TextType.button:
        return 15;
      case TextType.caption:
        return 14;
      case TextType.labelLarge:
        return 13;
      case TextType.labelMedium:
        return 12;
      case TextType.labelSmall:
        return 10;
    }
  }

  static FontWeight _getFontWeight(TextWeight textWeight) {
    switch (textWeight) {
      case TextWeight.bold:
        return FontWeight.w600;
      case TextWeight.semiBold:
        return FontWeight.w500;
      case TextWeight.regular:
        return FontWeight.w400;
      case TextWeight.semiLigth:
        return FontWeight.w300;
      case TextWeight.ligth:
        return FontWeight.w200;
    }
  }
}
