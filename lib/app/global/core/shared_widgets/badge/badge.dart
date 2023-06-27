import 'package:flutter/widgets.dart';
import 'package:safe2biz/app/global/core/shared_widgets/text/text.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/global/core/styles/spacing.dart';

class Badge extends StatelessWidget {
  const Badge(
    String label, {
    Key? key,
    this.colorLabel,
    this.colorBackground,
  })  : _label = label,
        super(key: key);

  final String _label;
  final Color? colorLabel;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: S2BSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: colorBackground ?? S2BColors.primaryColor,
        borderRadius: BorderRadius.circular(S2BSpacing.xs),
      ),
      alignment: Alignment.center,
      child: TextLabel.small(
        _label,
        fontWeight: FontWeight.w700,
        color: colorLabel ?? S2BColors.white,
      ),
    );
  }
}
