import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class BackgroundEffect extends StatelessWidget {
  const BackgroundEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .33,
      color: S2BColors.primaryColor,
    );
  }
}
