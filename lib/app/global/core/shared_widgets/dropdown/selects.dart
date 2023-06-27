// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/shared_widgets/calendar/cupertino_data_picker.dart';

const double _heightSelect = 250;

class SelectModel<T> {
  const SelectModel({
    required this.id,
    required this.text,
    this.item,
  });
  final String id;
  final String text;
  final T? item;
}

class Select<T> extends StatelessWidget {
  Select({
    Key? key,
    required this.listData,
    required this.onTapOk,
    this.title,
    this.looping = true,
    this.initialItem = 0,
  }) : super(key: key);
  final List<SelectModel> listData;
  final void Function(T? value) onTapOk;
  final String? title;
  final bool looping;
  final int initialItem;

  final _selectValue = ValueNotifier<T?>(null);

  @override
  Widget build(BuildContext context) {
    if (listData.isNotEmpty) {
      _selectValue.value ??= listData[initialItem].item as T;
    }
    return Material(
      color: Colors.white,
      child: Container(
        height: _heightSelect,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: S2BColors.black,
              width: 3,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextLabel.body(
                  title!,
                  // style: TextStyles.txtDefaultBlack,
                ),
              ),
            Expanded(
              child: Theme(
                data: ThemeData(accentColor: Colors.white),
                child: CupertinoPicker(
                  itemExtent: 50,
                  looping: looping,
                  scrollController: FixedExtentScrollController(
                    initialItem: initialItem,
                  ),
                  backgroundColor: Colors.white,
                  selectionOverlay: const _MySelectionOverlay(),
                  onSelectedItemChanged: (val) {
                    _selectValue.value = listData[val].item as T;
                  },
                  children: [
                    ...listData.map(
                      (item) {
                        return Container(
                          key: Key('${T.runtimeType}_${item.id}'),
                          alignment: Alignment.center,
                          child: Text(
                            item.text.trim(),
                            maxLines: 1,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BtnDefault(
              'Aceptar',
              onTap: () => onTapOk(_selectValue.value),
            )
          ],
        ),
      ),
    );
  }
}

class SelectDate extends StatelessWidget {
  const SelectDate(
      {Key? key,
      required this.onTapOk,
      this.title,
      this.initDate,
      this.maxDate,
      this.minDate})
      : super(key: key);

  final void Function(dynamic value) onTapOk;
  final String? title;
  final DateTime? initDate;
  final DateTime? minDate;
  final DateTime? maxDate;

  @override
  Widget build(BuildContext context) {
    final _selectValue = ValueNotifier<dynamic>(null);
    final _now = DateTime.now();
    return Material(
      color: Colors.white,
      child: Container(
        height: _heightSelect,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: S2BColors.black,
              width: 3,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextLabel.body(
                  title!,
                  // style: TextStyles.txtDefaultBlack,
                ),
              ),
            Expanded(
              child: Theme(
                data: ThemeData(accentColor: Colors.white),
                child: CupertinoDateFormatPicker(
                  format: const [Format.dd, Format.mm, Format.yyyy],
                  minDateTime: minDate ?? DateTime(_now.year - 70, 1, 1, 0, 0),
                  initialDateTime: initDate ?? _now,
                  maxDateTime: maxDate ?? _now,
                  selectionOverlay: const _MySelectionOverlay(),
                  onChange: (date, value) {
                    _selectValue.value = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            BtnDefault(
              'Aceptar',
              onTap: () => onTapOk(_selectValue.value),
            )
          ],
        ),
      ),
    );
  }
}

class _MySelectionOverlay extends StatelessWidget {
  const _MySelectionOverlay({
    Key? key,
    this.background = CupertinoColors.tertiarySystemFill,
    this.borderRadius = 0.0,
  }) : super(key: key);

  final Color background;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 9, right: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: CupertinoDynamicColor.resolve(background, context),
      ),
    );
  }
}

class SelectHour extends StatelessWidget {
  SelectHour({
    Key? key,
    required this.title,
    required this.onTapOk,
    this.initial,
  }) : super(key: key);

  final String? title;
  final String? initial;
  final void Function(String value) onTapOk;

  final ValueNotifier<String> hour =
      ValueNotifier<String>(DateTime.now().formatHour);

  @override
  Widget build(BuildContext context) {
    if (initial != null) {
      hour.value = initial!;
    }

    return Material(
      color: Colors.white,
      child: Container(
        height: _heightSelect,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: S2BColors.black,
              width: 3,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextLabel.body(
                  title!,
                  // style: TextStyles.txtDefaultBlack,
                ),
              ),
            Expanded(
              child: SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  initialDateTime: initial != null
                      ? DateTime.parse('2020-03-20 $initial')
                      : DateTime.now(),
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  onDateTimeChanged: (dateTime) =>
                      hour.value = dateTime.formatHour,
                ),
              ),
            ),
            BtnDefault(
              'Aceptar',
              onTap: () => onTapOk(hour.value),
            )
          ],
        ),
      ),
    );
  }

  @Deprecated('no esta en uso')
  DateTime getDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }
}
