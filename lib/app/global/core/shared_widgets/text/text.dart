import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class TextLabel {
  TextLabel._();

  ///h1 Text widget - fontSize 96
  static Widget h1(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    double? letterSpacing,
    int? maxLines,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.h1,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///h2 Text widget - fontSize 58
  static Widget h2(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    double? letterSpacing,
    int? maxLines,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.h2,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///h3 Text widget - fontSize 47
  static Widget h3(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    double? letterSpacing,
    int? maxLines,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.h3,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///h4 Text widget - fontSize 33
  static Widget h4(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    double? letterSpacing,
    int? maxLines,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.h4,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///h5 Text widget - fontSize 23
  static Widget h5(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    double? letterSpacing,
    int? maxLines,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.h5,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///h6 Text widget - fontSize 19
  static Widget h6(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    double? letterSpacing,
    int? maxLines,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.h6,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.bold,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///body Text widget - fontSize 16
  static Widget body(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    int? maxLines,
    double? letterSpacing,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.body,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        maxLines: maxLines,
        letterSpacing: letterSpacing,
      );

  ///labelText Text widget - fontSize 14
  static Widget labelText(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    int? maxLines,
    double? letterSpacing,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.label,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        maxLines: maxLines,
        letterSpacing: letterSpacing,
      );

  ///xSmall Text widget - fontSize 8
  static Widget xSmall(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    int? maxLines,
    double? letterSpacing,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.xSmall,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
      );

  ///small Text widget - fontSize 12
  static Widget small(
    String label, {
    Key? key,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? textOverflow,
    int? maxLines,
    double? letterSpacing,
  }) =>
      _TextGeneric(
        textKey: key,
        label: label,
        fontSize: S2BTypography.small,
        color: color ?? S2BColors.black,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        textAlign: textAlign,
        textOverflow: textOverflow,
        maxLines: maxLines,
        letterSpacing: letterSpacing,
      );
}

class _TextGeneric extends StatelessWidget {
  const _TextGeneric({
    required this.label,
    required this.fontSize,
    this.textKey,
    this.color,
    this.fontStyle,
    this.fontWeight,
    this.textOverflow,
    this.textAlign,
    this.letterSpacing,
    this.maxLines,
  }) : super(key: textKey);

  final Key? textKey;
  final String label;
  final double fontSize;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: S2BTypography.roboto,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle ?? FontStyle.normal,
        letterSpacing: letterSpacing,
      ),
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
