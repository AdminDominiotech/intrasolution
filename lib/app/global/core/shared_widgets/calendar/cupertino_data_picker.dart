// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<int> _solarMonthsOf31Days = <int>[1, 3, 5, 7, 8, 10, 12];

enum Format { d, dd, m, mm, yyyy }
enum CupertinoDatePickerLocale { en, es }
const String datePickerMinDateTime = '1900-01-01 00:00:00';
const String datePickerMaxDateTime = '2100-12-31 23:59:59';

class CupertinoDateFormatPicker extends StatefulWidget {
  const CupertinoDateFormatPicker({
    Key? key,
    this.minDateTime,
    this.maxDateTime,
    this.initialDateTime,
    this.locale = CupertinoDatePickerLocale.en,
    this.format = const [Format.dd, Format.mm, Format.yyyy],
    this.separator = '/',
    this.selectionOverlay,
    required this.onChange,
  }) : super(key: key);

  final DateTime? minDateTime, maxDateTime, initialDateTime;
  final CupertinoDatePickerLocale locale;
  final void Function(DateTime value, String valueFormate) onChange;
  final List<Format> format;
  final String separator;
  final Widget? selectionOverlay;

  @override
  State<StatefulWidget> createState() => _CupertinoDatePickerWidgetState();
}

class _CupertinoDatePickerWidgetState extends State<CupertinoDateFormatPicker> {
  late DateTime _minDateTime, _maxDateTime;
  late int _currYear, _currMonth, _currDay;
  late List<int> _yearRange, _monthRange, _dayRange;

  late FixedExtentScrollController _yyyyCtrl, _mmCtrl, _mCtrl, _dCtrl, _ddCtrl;
  late final Map<Format, FixedExtentScrollController> _scrollCtrlMap = {
    Format.d: _dCtrl,
    Format.dd: _ddCtrl,
    Format.m: _mCtrl,
    Format.mm: _mmCtrl,
    Format.yyyy: _yyyyCtrl,
  };

  @override
  void initState() {
    initial(widget.minDateTime, widget.maxDateTime, widget.initialDateTime);
    super.initState();
  }

  void initial(
    DateTime? minDateTime,
    DateTime? maxDateTime,
    DateTime? initialDateTime,
  ) {
    // handle current selected year、month、day
    final initDateTime = initialDateTime ??
        DateTime.parse(
          '${DateTime.now().year - 100}-01-01 00:00:00',
        );
    _currYear = initDateTime.year;
    _currMonth = initDateTime.month;
    _currDay = initDateTime.day;
    // handle DateTime range
    _minDateTime = minDateTime ?? DateTime.parse(datePickerMinDateTime);
    _maxDateTime = maxDateTime ?? DateTime.parse(datePickerMaxDateTime);

    // limit the range of year
    _yearRange = _calcYearRange();
    // limit the range of month
    _monthRange = _calcMonthRange();
    // limit the range of day
    _dayRange = _calcDayRange();

    // create scroll controller
    var y = (_currYear - _yearRange.first);
    _yyyyCtrl = FixedExtentScrollController(
      initialItem: y <= 0 ? 0 : y,
    );
    _mCtrl = FixedExtentScrollController(
      initialItem: _currMonth - _monthRange.first,
    );
    _mmCtrl = FixedExtentScrollController(
      initialItem: _currMonth - _monthRange.first,
    );
    _dCtrl = FixedExtentScrollController(
      initialItem: _currDay - _dayRange.first,
    );
    _ddCtrl = FixedExtentScrollController(
      initialItem: _currDay - _dayRange.first,
    );
    _onChangeExecute();
  }

  @override
  void dispose() {
    _yyyyCtrl.dispose();
    _mmCtrl.dispose();
    _mCtrl.dispose();
    _ddCtrl.dispose();
    _dCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listFormat = widget.format;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        listFormat.length,
        (index) {
          var format = listFormat[index];
          final ctrl = _scrollCtrlMap[listFormat[index]];
          return _DatePickerComponent(
            valueRange: getValue(listFormat[index]),
            controller: ctrl!,
            selectionOverlay: widget.selectionOverlay,
            valueChanged: (value) {
              if (format == Format.yyyy) {
                _changeYearSelection(value);
              } else if (format == Format.m || format == Format.mm) {
                _changeMonthSelection(value);
              } else if (format == Format.d || format == Format.dd) {
                _changeDaySelection(value);
              }
            },
          );
        },
      ),
    );
  }

  List<String> getValue(Format format) {
    var list = <String>[];
    switch (format) {
      case Format.d:
        // var range = _calcDayRange();
        for (var i = _dayRange.first; i <= _dayRange.last; i++) {
          list.add(i.toString());
        }
        break;
      case Format.dd:
        // var min = _calcDayRange();
        for (var i = _dayRange.first; i <= _dayRange.last; i++) {
          list.add(_formatNum(i));
        }
        break;
      case Format.m:
        // var range = _calcMonthRange();
        for (var i = _monthRange.first; i <= _monthRange.last; i++) {
          list.add(i.toString());
        }
        break;
      case Format.mm:
        // var min = _calcMonthRange();
        for (var i = _monthRange.first; i <= _monthRange.last; i++) {
          list.add(_formatNum(i));
        }
        break;
      case Format.yyyy:
        // var min = _calcYearRange();
        for (var i = _yearRange.first; i <= _yearRange.last; i++) {
          list.add(_formatNum(i, lenth: 4));
        }
        break;
      default:
    }

    return list;
  }

  static String _formatNum(int val, {int lenth = 2}) {
    if (lenth == 2) {
      return (val < 10) ? '0$val' : '$val';
    } else {
      return '$val';
    }
  }

  /// change the selection of year picker
  void _changeYearSelection(int index) {
    var _yearRangeNew = _calcYearRange();
    var year = _yearRangeNew.first + index;
    if (_currYear != year) {
      _currYear = year;
      _changeDate();
    }
  }

  /// change the selection of month picker
  void _changeMonthSelection(int index) {
    final _monthRangeNew = _calcMonthRange();
    final month = _monthRangeNew.first + index;
    if (_currMonth != month) {
      _currMonth = month;
      _changeDate();
    }
  }

  /// change the selection of day picker
  void _changeDaySelection(int index) {
    final _dayRangeNew = _calcDayRange();
    final dayOfMonth = _dayRangeNew.first + index;
    if (_currDay != dayOfMonth) {
      _currDay = dayOfMonth;
      _changeDate();
    }
  }

  /// change range of month and day
  void _changeDate() {
    var update = false;
    final monthRangeNew = _calcMonthRange();
    if (_monthRange.first != monthRangeNew.first ||
        _monthRange.last != monthRangeNew.last) {
      _currMonth =
          max(min(_currMonth, monthRangeNew.last), monthRangeNew.first);
      update = true;
    }

    final dayRangeNew = _calcDayRange();
    if (_dayRange.first != dayRangeNew.first ||
        _dayRange.last != dayRangeNew.last) {
      _currDay = max(min(_currDay, dayRangeNew.last), dayRangeNew.first);
      update = true;
    }

    if (update) {
      setState(() {
        _monthRange = monthRangeNew;
        _dayRange = dayRangeNew;
      });
    }
    _onChangeExecute();
  }

  void _onChangeExecute() {
    final dateTime = DateTime(_currYear, _currMonth, _currDay);
    widget.onChange(dateTime, getValueFormat());
  }

  String getValueFormat() {
    var textFormat = '';
    for (var i = 0; i < widget.format.length; i++) {
      var type = widget.format[i];
      switch (type) {
        case Format.d:
          textFormat += _currDay.toString();
          break;
        case Format.dd:
          textFormat += _formatNum(_currDay);
          break;
        case Format.m:
          textFormat += _currMonth.toString();
          break;
        case Format.mm:
          textFormat += _formatNum(_currMonth);
          break;
        case Format.yyyy:
          textFormat += _formatNum(_currYear, lenth: 4);
          break;
        default:
      }
      if (i < widget.format.length - 1) {
        textFormat += widget.separator;
      }
    }
    return textFormat;
  }

  /// calculate the count of day in current month
  int _calcDayCountOfMonth() {
    if (_currMonth == 2) {
      return _isLeapYear(_currYear) ? 29 : 28;
    } else if (_solarMonthsOf31Days.contains(_currMonth)) {
      return 31;
    }
    return 30;
  }

  /// whether or not is leap year
  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  /// calculate the range of year
  List<int> _calcYearRange() {
    return [_minDateTime.year, _maxDateTime.year];
  }

  /// calculate the range of month
  List<int> _calcMonthRange() {
    var minMonth = 1, maxMonth = 12;
    var minYear = _minDateTime.year;
    var maxYear = _maxDateTime.year;
    if (minYear == _currYear) minMonth = _minDateTime.month;
    if (maxYear == _currYear) maxMonth = _maxDateTime.month;
    return [minMonth, maxMonth];
  }

  /// calculate the range of day
  List<int> _calcDayRange({int? currMonth}) {
    var minDay = 1, maxDay = _calcDayCountOfMonth();
    var minYear = _minDateTime.year;
    var maxYear = _maxDateTime.year;
    var minMonth = _minDateTime.month;
    var maxMonth = _maxDateTime.month;
    currMonth ??= _currMonth;
    if (minYear == _currYear && currMonth == minMonth) {
      minDay = _minDateTime.day;
    }
    if (maxYear == _currYear && maxMonth == currMonth) {
      maxDay = _maxDateTime.day;
    }
    return [minDay, maxDay];
  }
}

class _DatePickerComponent extends StatelessWidget {
  const _DatePickerComponent({
    Key? key,
    required this.valueRange,
    required this.valueChanged,
    required this.controller,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  }) : super(key: key);

  final List<String> valueRange;
  final ValueChanged<int> valueChanged;
  final FixedExtentScrollController controller;
  final Widget? selectionOverlay;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: CupertinoPicker.builder(
          backgroundColor: Colors.transparent,
          itemExtent: 50,
          onSelectedItemChanged: valueChanged,
          childCount: valueRange.length,
          scrollController: controller,
          selectionOverlay: selectionOverlay,
          itemBuilder: (context, index) => Container(
            alignment: Alignment.center,
            child: Text(valueRange[index]),
          ),
        ),
      ),
    );
  }
}
