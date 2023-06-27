import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class CkeckBox extends StatefulWidget {
  const CkeckBox({
    Key? key,
    required this.value,
    this.onChanged,
    this.colorActive,
    this.size,
  }) : super(key: key);

  final bool value;
  final void Function(bool)? onChanged;
  final Color? colorActive;
  final double? size;

  @override
  State<CkeckBox> createState() => _CkeckBoxState();
}

class _CkeckBoxState extends State<CkeckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged!.call(!widget.value);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(inputBorderRadius),
        child: Container(
          width: widget.size ?? 20,
          height: widget.size ?? 20,
          decoration: BoxDecoration(
            color: widget.value
                ? widget.colorActive ?? S2BColors.primaryColor
                : Colors.transparent,
            border: Border.all(
              color: S2BColors.secondaryColor,
              width: inputWidthBorder,
            ),
            borderRadius: BorderRadius.circular(inputBorderRadius),
          ),
          alignment: Alignment.center,
          child: widget.value
              ? Icon(
                  Icons.check,
                  size: widget.size != null ? (widget.size! - 5) : 15,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
