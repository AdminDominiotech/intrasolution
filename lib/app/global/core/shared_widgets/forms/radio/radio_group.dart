// Flutter imports:
import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class RadioGroup extends StatefulWidget {
  RadioGroup({
    Key? key,
    required this.onChange,
    required this.listItemRadios,
    required this.label,
    this.initValue = 0,
  }) : super(key: key);

  final void Function(ItemRadio value) onChange;
  final List<ItemRadio> listItemRadios;
  late int initValue;
  final String label;

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel.labelText(widget.label),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: S2BSpacing.xxs,
          ),
          ...List.generate(
            widget.listItemRadios.length,
            (index) => Theme(
              data: ThemeData(
                unselectedWidgetColor: S2BColors.silver,
              ),
              child: SizedBox(
                width: size.width * .35,
                child: RadioListTile<int>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      S2BRadius.xs,
                    ),
                  ),
                  title: TextLabel.small(
                    widget.listItemRadios[index].title,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: widget.listItemRadios[index].subTitle != null
                      ? TextLabel.labelText(
                          widget.listItemRadios[index].subTitle!,
                        )
                      : null,
                  groupValue: widget.initValue,
                  value: index,
                  contentPadding: EdgeInsets.zero,
                  activeColor: S2BColors.primaryColor,
                  onChanged: (val) {
                    setState(() => widget.initValue = val!);
                    widget.onChange(widget.listItemRadios[widget.initValue]);
                  },
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

class ItemRadio {
  const ItemRadio({required this.title, this.subTitle, this.value});
  final String title;
  final String? subTitle;
  final dynamic value;
}
