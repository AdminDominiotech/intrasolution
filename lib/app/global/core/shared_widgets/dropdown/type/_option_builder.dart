import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';

class OptionsBuilder<T> extends StatelessWidget {
  const OptionsBuilder({
    Key? key,
    required this.options,
    required this.itemBuilder,
    required this.onSelect,
  }) : super(key: key);

  final Items<T> options;
  final OnSelect<T>? onSelect;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return options.isEmpty
        ? EmptyData()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            padding: const EdgeInsets.symmetric(
              horizontal: S2BSpacing.sm,
            ),
            itemBuilder: (ctxt, i) {
              return InkWell(
                child: itemBuilder.call(ctxt, options[i].value),
                onTap: () => onSelect?.call(
                  options[i].label,
                  options[i].value,
                ),
              );
            },
          );
  }
}
