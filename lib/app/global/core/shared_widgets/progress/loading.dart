import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key, this.color}) : super(key: key);

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(color ?? S2BColors.primaryColor),
      ),
    );
  }
}
