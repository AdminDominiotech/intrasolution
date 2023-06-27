import 'package:flutter/widgets.dart';
import 'package:safe2biz/app/global/core/core.dart';

class ItemSelect extends StatelessWidget {
  const ItemSelect(this.title, {Key? key, this.label = '', this.subLabel = ''})
      : super(key: key);

  final String title;
  final String label;
  final String subLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: S2BColors.colorInactive,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: S2BSpacing.md,
        horizontal: S2BSpacing.md,
      ),
      child: Column(
        children: [
          TextLabel.labelText(
            title,
            maxLines: 2,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            textOverflow: TextOverflow.ellipsis,
            color: label.isEmpty ? S2BColors.black : S2BColors.primaryColor,
            // truncate: true,
          ),
          if (label.isNotEmpty)
            TextLabel.labelText(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              // truncate: true,
            ),
          if (subLabel.isNotEmpty)
            TextLabel.labelText(
              subLabel,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              color: S2BColors.silver,
              // truncate: true,
            ),
        ],
      ),
    );
  }
}
