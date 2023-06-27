import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

import '../forms/radio/radio_buton_option.dart';

class RadioButtonsList extends StatefulWidget {
  const RadioButtonsList({
    Key? key,
    required this.items,
    required this.onTapItem,
  }) : super(key: key);
  final List<RadioButtonOption> items;
  final Function(RadioButtonOption) onTapItem;

  @override
  _RadioButtonsListState createState() => _RadioButtonsListState();
}

class _RadioButtonsListState extends State<RadioButtonsList> {
  RadioButtonOption? itemSelected;
  bool initSelect = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ...widget.items.map(
          (item) {
            if (!initSelect && item.isChecked) {
              initSelect = true;
              _onTap(item);
            }
            return Column(
              children: [
                ListRadioButton(
                  item: item,
                  onTap: () => _onTap(item),
                  isChecked:
                      itemSelected != null ? itemSelected == item : false,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _onTap(RadioButtonOption item) {
    itemSelected = item;
    widget.onTapItem(item);
    _updateView();
  }

  void _updateView() {
    if (mounted) {
      setState(() {});
    }
  }
}
