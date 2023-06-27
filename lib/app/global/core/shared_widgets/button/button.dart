// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:safe2biz/app/global/core/core.dart';

// enum BtnType {
//   fill,

//   outlined,

//   text,

//   link
// }
// class BtnSize {
//   const BtnSize({
//     required this.textLabel,
//     required this.paddingH,
//     required this.paddingV,
//   });

//   final Widget Function(
//     String label, {
//     Color? color,
//     FontWeight? fontWeight,
//     Key? key,
//     TextAlign? textAlign,
//   }) textLabel;
//   final double paddingH;
//   final double paddingV;
// }

// class BtnDefaultSize {
//   BtnDefaultSize._();

//   static const BtnSize xs = BtnSize(
//     paddingH: 10,
//     paddingV: 6,
//     textLabel: TextLabel.small,
//   );
//   static const BtnSize sm = BtnSize(
//     paddingH: 18,
//     paddingV: 8,
//     textLabel: TextLabel.small,
//   );
//   static const BtnSize md = BtnSize(
//     paddingH: 20,
//     paddingV: 15,
//     textLabel: TextLabel.labelText,
//   );
//   static const BtnSize lg = BtnSize(
//     paddingH: 24,
//     paddingV: 15,
//     textLabel: TextLabel.body,
//   );
//   static const BtnSize xl = BtnSize(
//     paddingH: 28,
//     paddingV: 20,
//     textLabel: TextLabel.h6,
//   );
// }

// class BtnInterface {
//   BtnInterface({
//     required this.buttonColor,
//     required this.labelColor,
//     this.labelFontWeight,
//     this.showIcon = false,
//     this.hasBorder = false,
//     this.borderColor = S2BColors.white,
//     this.icon = Icons.arrow_forward,
//     this.iconColor = S2BColors.black,
//     this.iconSize = 16,
//     this.iconIsSvg = false,
//     this.svgUrl,
//     this.svgSize = 16,
//     this.svgColor,
//     this.showIconAtRight = true,
//     this.showShadow = false,
//     this.iconMargin = 8,
//     this.assetPackage,
//     this.btnSize = BtnDefaultSize.md,
//     this.btnBorderRadius = 25.0,
//   });

//   Color buttonColor;
//   Color labelColor;
//   final FontWeight? labelFontWeight;
//   final bool showIcon;
//   final bool hasBorder;
//   final Color borderColor;
//   final IconData icon;
//   final Color? iconColor;
//   final double iconSize;
//   final bool iconIsSvg;
//   final String? svgUrl;
//   final double svgSize;
//   final Color? svgColor;
//   final bool showIconAtRight;
//   final bool showShadow;
//   final double iconMargin;
//   final String? assetPackage;
//   final BtnSize btnSize;
//   final double btnBorderRadius;
// }

// class BtnDefault extends StatelessWidget {
//   const BtnDefault({
//     Key? key,
//     required this.label,
//     required this.onTap,
//     this.colorButton,
//     this.colorText,
//     this.icon = false,
//     this.border = false,
//     this.colorBorder = Colors.white,
//     this.paddingH = 20,
//     this.paddingV = 15,
//     this.fontSize = 16,
//     this.fontWeight = FontWeight.w600,
//     this.iconData = Icons.arrow_forward,
//     this.colorIcon = Colors.black,
//     this.sizeIcon = 16,
//     this.imgSvg = false,
//     this.imgUrl,
//     this.sizeImg = 25,
//     this.colorImg,
//     this.iconRight = true,
//     this.showShadow = false,
//     this.iconMargin = S2BSpacing.xs,
//     this.loading = false,
//   }) : super(key: key);

//   final String label;
//   final GestureTapCallback? onTap;
//   final Color? colorButton;
//   final Color? colorText;
//   final bool icon;
//   final bool border;
//   final Color colorBorder;
//   final double paddingH;
//   final double paddingV;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final IconData iconData;
//   final Color colorIcon;
//   final double sizeIcon;
//   final bool imgSvg;
//   final String? imgUrl;
//   final double sizeImg;
//   final Color? colorImg;
//   final bool iconRight;
//   final bool showShadow;
//   final bool loading;
//   final double iconMargin;

//   @override
//   Widget build(BuildContext context) {
//     return _TulBtnGeneric(
//       label: label,
//       onTap: onTap,
//       btnSize: BtnSize(
//         paddingH: paddingH,
//         paddingV: paddingV,
//         textLabel: TextLabel.labelText,
//       ),
//       btnType: BtnInterface(
//         buttonColor: colorButton ?? S2BColors.primaryColor,
//         labelColor: colorText ?? S2BColors.white,
//         showIcon: icon,
//         hasBorder: border,
//         borderColor: colorBorder,
//         icon: iconData,
//         iconColor: colorIcon,
//         iconSize: sizeIcon,
//         iconIsSvg: imgSvg,
//         svgUrl: imgUrl,
//         svgSize: sizeImg,
//         svgColor: colorImg,
//         showIconAtRight: iconRight,
//         showShadow: showShadow,
//         iconMargin: iconMargin,
//         labelFontWeight: fontWeight,
//       ),
//       loading: loading,
//     );
//   }
// }

// class _TulBtnGeneric extends StatelessWidget {
//   const _TulBtnGeneric({
//     Key? key,
//     required this.label,
//     required this.onTap,
//     required this.btnSize,
//     required this.btnType,
//     this.loading = false,
//   }) : super(key: key);

//   final String label;
//   final GestureTapCallback? onTap;
//   final BtnSize btnSize;
//   final BtnInterface btnType;
//   final bool loading;

//   @override
//   Widget build(BuildContext context) {
//     return ButtonTheme(
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.disabled)) {
//                 return btnType.buttonColor == Colors.transparent
//                     ? S2BColors.disabledButtonColor.withOpacity(0.2)
//                     : S2BColors.disabledButtonColor;
//               }
//               return btnType.buttonColor;
//             },
//           ),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(btnType.btnBorderRadius),
//               side: btnType.hasBorder
//                   ? BorderSide(
//                       color: btnType.borderColor,
//                     )
//                   : BorderSide.none,
//             ),
//           ),
//           shadowColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.disabled)) {
//                 return btnType.buttonColor == Colors.transparent
//                     ? Colors.transparent
//                     : S2BColors.disabledColor.withOpacity(0.6);
//               }
//               return btnType.buttonColor.withOpacity(0.6);
//             },
//           ),
//           elevation: MaterialStateProperty.all(btnType.showShadow ? 8 : 0),
//           padding: MaterialStateProperty.all(
//             EdgeInsets.symmetric(
//               vertical: btnSize.paddingV,
//               horizontal: btnSize.paddingH,
//             ),
//           ),
//           foregroundColor: MaterialStateProperty.all(
//             btnType.buttonColor.withOpacity(0.6),
//           ),
//         ),
//         onPressed: loading ? () {} : onTap,
//         child: loading
//             ? const _MinLoading()
//             : !btnType.showIcon
//                 ? _text(context)
//                 : _textIcon(context),
//       ),
//     );
//   }

//   Widget _text(BuildContext context) {
//     return btnSize.textLabel(
//       label,
//       color: onTap == null ? S2BColors.whiteSecundary : btnType.labelColor,
//       fontWeight: btnType.labelFontWeight,
//     );
//   }

//   Widget _textIcon(BuildContext context) {
//     Widget icon() {
//       return !btnType.iconIsSvg
//           ? Icon(
//               btnType.icon,
//               color: btnType.iconColor ?? S2BColors.black,
//               size: btnType.iconSize,
//             )
//           : SvgPicture.asset(
//               btnType.svgUrl ?? '',
//               width: btnType.svgSize,
//               color: btnType.svgColor,
//               package: btnType.assetPackage,
//             );
//     }

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         !btnType.showIconAtRight
//             ? Flexible(
//                 child: Container(
//                   margin: EdgeInsets.only(right: btnType.iconMargin),
//                   child: icon(),
//                 ),
//               )
//             : const SizedBox.shrink(),
//         _text(context),
//         btnType.showIconAtRight
//             ? Container(
//                 margin: EdgeInsets.only(left: btnType.iconMargin),
//                 child: icon(),
//               )
//             : const SizedBox.shrink(),
//       ],
//     );
//   }
// }

// class _MinLoading extends StatelessWidget {
//   const _MinLoading({
//     Key? key,
//     this.color = S2BColors.white,
//   }) : super(key: key);

//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 20,
//       height: 20,
//       child: CircularProgressIndicator(
//         color: color,
//         strokeWidth: 1,
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/shared_widgets/text/label.dart';
import 'package:safe2biz/app/global/core/styles/styles.dart';

enum BtnType {
  fill,

  outlined,

  text,

  link
}

class BtnDefault extends StatelessWidget {
  const BtnDefault(
    this.text, {
    Key? key,
    this.loading = false,
    this.enabled = true,
    this.onTap,
    this.minWidth = 200,
    this.color,
    this.colorText,
    this.type = BtnType.fill,
  }) : super(key: key);

  ///
  final bool loading;

  ///
  final VoidCallback? onTap;

  ///
  final String text;

  ///
  final double minWidth;

  ///
  final Color? color;

  final Color? colorText;

  ///
  final bool enabled;

  ///
  final BtnType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: () {
            switch (type) {
              case BtnType.fill:
                return CupertinoButton(
                  minSize: 36,
                  padding: const EdgeInsets.symmetric(
                    horizontal: S2BSpacing.sm,
                    vertical: S2BSpacing.sl,
                  ),
                  onPressed: !loading ? onTap : () {},
                  color: color ?? S2BColors.primaryColor,
                  borderRadius: BorderRadius.circular(S2BRadius.lg),
                  child: !loading
                      ? Label(
                          text,
                          color: colorText ?? Colors.white,
                          textAlign: TextAlign.center,
                          textType: TextType.button,
                          textWeight: TextWeight.bold,
                        )
                      : const _MinLoading(color: Colors.white),
                );
              case BtnType.outlined:
                return OutlinedButton(
                  onPressed: !loading ? onTap : () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(minWidth, 44)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(S2BRadius.xs),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: color ?? Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: S2BSpacing.sm,
                      ),
                    ),
                  ),
                  child: !loading
                      ? Label(
                          text,
                          color: colorText ??
                              Theme.of(context).colorScheme.primary,
                          textAlign: TextAlign.center,
                          textType: TextType.button,
                          textWeight: TextWeight.bold,
                        )
                      : _MinLoading(
                          color: color ?? Theme.of(context).colorScheme.primary,
                        ),
                );
              case BtnType.text:
                return OutlinedButton(
                  onPressed: !loading ? onTap : () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.5),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(minWidth, 44)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(S2BRadius.xs),
                      ),
                    ),
                    side: MaterialStateProperty.all(BorderSide.none),
                  ),
                  child: !loading
                      ? Label(
                          text,
                          color: colorText ??
                              Theme.of(context).colorScheme.primary,
                          textAlign: TextAlign.center,
                        )
                      : _MinLoading(
                          color: color ?? Theme.of(context).colorScheme.primary,
                        ),
                );
              case BtnType.link:
                return TextButton(
                  onPressed: !loading ? onTap : () {},
                  child: !loading
                      ? Label(
                          text,
                          color: colorText ??
                              Theme.of(context).colorScheme.primary,
                          textAlign: TextAlign.center,
                          textType: TextType.button,
                          underline: true,
                        )
                      : _MinLoading(
                          color: color ?? Theme.of(context).colorScheme.primary,
                        ),
                );
            }
          }(),
        ),
      ),
    );
  }
}

class _MinLoading extends StatelessWidget {
  const _MinLoading({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 1,
      ),
    );
  }
}
