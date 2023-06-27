import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/shared_widgets/dropdown/type/_option_builder.dart';
import 'package:safe2biz/app/ui/module_ui.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);
typedef Items<T> = List<Option<T>>;
typedef ItemFuture<T> = Future<Items<T>> Function()?;
typedef OnSelect<T> = void Function(String label, T value)?;
typedef OnChange = void Function(String value)?;
typedef OnValidator<T> = String? Function(String label, T value);

class Option<T> {
  const Option(
    this.label,
    this.value,
  );

  final String label;
  final T value;
}

class PopupSelect {
  PopupSelect();

  static void show<T>({
    required BuildContext context,
    String? title,
    required Items<T> initialList,
    OnSelect<T>? onSelect,
    bool? filter,
    required ItemWidgetBuilder<T> itemBuilder,
  }) async {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return _SelectPopup<T>(
          filter: filter ?? false,
          initialList: initialList,
          itemBuilder: itemBuilder,
          title: title,
          onSelect: onSelect,
        );
      },
    );
  }
}

class _SelectPopup<T> extends StatefulWidget {
  const _SelectPopup({
    Key? key,
    this.controller,
    this.title,
    this.filter = false,
    this.onSelect,
    required this.initialList,
    required this.itemBuilder,
  }) : super(key: key);

  /// Controller for [TextEditingController]
  final TextEditingController? controller;

  /// Placehorder
  final String? title;

  /// only works when creating an initial list with [initialList]
  final bool filter;
  final Items<T> initialList;
  final ItemWidgetBuilder<T> itemBuilder;
  final OnSelect<T>? onSelect;

  @override
  State<_SelectPopup<T>> createState() => _SelectPopupState<T>();
}

class _SelectPopupState<T> extends State<_SelectPopup<T>> {
  late Items<T> _list;
  late Items<T> _listTemp;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _list = widget.initialList;
    _listTemp = widget.initialList;

    _controller = widget.controller ?? TextEditingController();
  }

  Future<void> onChange(String value) async {
    if (widget.filter) {
      _filter(value);
    }
  }

  void _filter(String val) {
    if (widget.filter) {
      var newList = Items<T>.empty();
      if (val.isEmpty) {
        newList = _listTemp;
      } else {
        newList = widget.initialList
            .where((e) => e.label.toLowerCase().contains(val.toLowerCase()))
            .toList()
          ..sort((a, b) => a.label.compareTo(b.label));
      }
      _list = newList;
      _updateView();
    }
  }

  void _updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SafeArea(
        child: Material(
          color: S2BColors.black.withOpacity(.75),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: S2BSpacing.lg),
                child: TextLabel.h6(
                  widget.title ?? '',
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color:
                        _list.isEmpty ? S2BColors.background : S2BColors.white,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: S2BSpacing.md,
                    vertical: S2BSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.filter)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: S2BSpacing.sl,
                            horizontal: S2BSpacing.md,
                          ),
                          child: InputTextField(
                            controller: _controller,
                            onChanged: onChange,
                            placeholder: UiValues.quien,
                            trailingIcon: const InputTrailingIcon(
                              Icons.search,
                              color: S2BColors.primaryColor,
                            ),
                          ),
                        ),
                      Flexible(
                        child: OptionsBuilder<T>(
                          options: _list,
                          onSelect: (label, value) {
                            widget.onSelect?.call(label, value);
                            _controller.text = label;
                          },
                          itemBuilder: widget.itemBuilder,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
