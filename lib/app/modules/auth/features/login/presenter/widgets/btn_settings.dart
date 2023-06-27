import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe2biz/app/global/core/core.dart';

class BtnSettings extends StatelessWidget {
  const BtnSettings({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.only(
          left: S2BSpacing.md,
          top: S2BSpacing.xxl,
        ),
        child: Icon(
          FontAwesomeIcons.gear,
          color: S2BColors.white,
        ),
      ),
    );
  }
}
