import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/ui/module_ui.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    Key? key,
    this.title = 'No hay registros',
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: box.maxHeight * .1,
              left: 0,
              right: 0,
              child: Image.asset(
                UiValues.noDataIconGif,
                height: box.maxHeight * .5,
                width: box.maxWidth * .9,
              ),
            ),
            Positioned(
              top: box.maxHeight * .5,
              left: 0,
              right: 0,
              child: TextLabel.h6(
                title,
                textAlign: TextAlign.center,
                color: S2BColors.black.withOpacity(.65),
              ),
            ),
          ],
        );
      },
    );
  }
}
