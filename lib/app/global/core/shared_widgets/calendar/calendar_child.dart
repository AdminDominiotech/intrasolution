// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:safe2biz/app/global/core/core.dart';

const Duration _monthScrollDuration = Duration(milliseconds: 200);

const double _dayPickerRowHeight = 60.0;
const int _maxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
// One extra row for the day-of-week header.
const double _maxDayPickerHeight =
    _dayPickerRowHeight * (_maxDayPickerRowCount + 1);
const double _monthPickerHorizontalPadding = 8.0;

const int _yearPickerColumnCount = 3;
const double _yearPickerPadding = 16.0;
const double _yearPickerRowHeight = 52.0;
const double _yearPickerRowSpacing = 8.0;

const double _subHeaderHeight = 52.0;
const double _monthNavButtonsWidth = 108.0;

class MaterialCalendarWithChild extends StatefulWidget {
  MaterialCalendarWithChild({
    Key? key,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required this.onDateChanged,
    this.onDisplayedMonthChanged,
    this.initialCalendarMode = DatePickerMode.day,
    this.selectableDayPredicate,
    this.onChildBuild,
  })  : initialDate = dateOnly(initialDate),
        firstDate = dateOnly(firstDate),
        lastDate = dateOnly(lastDate),
        super(key: key) {
    assert(
      !this.lastDate.isBefore(this.firstDate),
      'lastDate ${this.lastDate} must be on '
      'or after firstDate ${this.firstDate}.',
    );
    assert(
      !this.initialDate.isBefore(this.firstDate),
      'initialDate ${this.initialDate} must be '
      'on or after firstDate ${this.firstDate}.',
    );
    assert(
      !this.initialDate.isAfter(this.lastDate),
      'initialDate ${this.initialDate} must be '
      'on or before lastDate ${this.lastDate}.',
    );
    assert(
      selectableDayPredicate == null ||
          selectableDayPredicate!(this.initialDate),
      'Provided initialDate ${this.initialDate} '
      'must satisfy provided selectableDayPredicate.',
    );
  }

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// Called when the user selects a date in the picker.
  final ValueChanged<DateTime> onDateChanged;

  /// Called when the user navigates to a new month/year in the picker.
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  /// The initial display of the calendar picker.
  final DatePickerMode initialCalendarMode;

  final SelectableDayPredicate? selectableDayPredicate;

  final Widget Function(DateTime date)? onChildBuild;

  @override
  _CalendarDatePickerState createState() => _CalendarDatePickerState();
}

class _CalendarDatePickerState extends State<MaterialCalendarWithChild> {
  bool _announcedInitialDate = false;
  late DatePickerMode _mode;
  late DateTime _currentDisplayedMonthDate;
  late DateTime _selectedDate;
  final GlobalKey _monthPickerKey = GlobalKey();
  final GlobalKey _yearPickerKey = GlobalKey();
  late MaterialLocalizations _localizations;
  late TextDirection _textDirection;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialCalendarMode;
    _currentDisplayedMonthDate =
        DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
      SemanticsService.announce(
        _localizations.formatFullDate(_selectedDate),
        _textDirection,
      );
    }
  }

  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
    }
  }

  void _handleModeChanged(DatePickerMode mode) {
    _vibrate();
    setState(() {
      _mode = mode;
      if (_mode == DatePickerMode.day) {
        SemanticsService.announce(
          _localizations.formatMonthYear(_selectedDate),
          _textDirection,
        );
      } else {
        SemanticsService.announce(
          _localizations.formatYear(_selectedDate),
          _textDirection,
        );
      }
    });
  }

  void _handleMonthChanged(DateTime date) {
    setState(() {
      if (_currentDisplayedMonthDate.year != date.year ||
          _currentDisplayedMonthDate.month != date.month) {
        _currentDisplayedMonthDate = DateTime(date.year, date.month);
        widget.onDisplayedMonthChanged?.call(_currentDisplayedMonthDate);
      }
    });
  }

  void _handleYearChanged(DateTime value) {
    _vibrate();

    if (value.isBefore(widget.firstDate)) {
      value = widget.firstDate;
    } else if (value.isAfter(widget.lastDate)) {
      value = widget.lastDate;
    }

    setState(() {
      _mode = DatePickerMode.day;
      _handleMonthChanged(value);
    });
  }

  void _handleDayChanged(DateTime value) {
    _vibrate();
    setState(() {
      _selectedDate = value;
      widget.onDateChanged.call(_selectedDate);
    });
  }

  Widget _buildPicker() {
    switch (_mode) {
      case DatePickerMode.day:
        return _MonthPicker(
          key: _monthPickerKey,
          initialMonth: _currentDisplayedMonthDate,
          currentDate: DateTime.now(),
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          selectedDate: _selectedDate,
          onChanged: _handleDayChanged,
          onDisplayedMonthChanged: _handleMonthChanged,
          selectableDayPredicate: widget.selectableDayPredicate,
          onChildBuild: widget.onChildBuild,
        );
      case DatePickerMode.year:
        return Padding(
          padding: const EdgeInsets.only(top: _subHeaderHeight),
          child: _YearPicker(
            key: _yearPickerKey,
            currentDate: DateTime.now(),
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _currentDisplayedMonthDate,
            selectedDate: _selectedDate,
            onChanged: _handleYearChanged,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: SizedBox(
            height: _maxDayPickerHeight,
            child: _buildPicker(),
          ),
        ),
        _DatePickerModeToggleButton(
          mode: _mode,
          title: '${_currentDisplayedMonthDate.completeMonth} '
              '${_currentDisplayedMonthDate.year}',
          onTitlePressed: () {
            // Toggle the day/year mode.
            _handleModeChanged(
              _mode == DatePickerMode.day
                  ? DatePickerMode.year
                  : DatePickerMode.day,
            );
          },
        ),
      ],
    );
  }
}

/// A button that used to toggle the [DatePickerMode] for a date picker.
///
/// This appears above the calendar grid and allows the user to toggle the
/// [DatePickerMode] to display either the calendar view or the year list.
class _DatePickerModeToggleButton extends StatefulWidget {
  const _DatePickerModeToggleButton({
    required this.mode,
    required this.title,
    required this.onTitlePressed,
  });

  /// The current display of the calendar picker.
  final DatePickerMode mode;

  /// The text that displays the current month/year being viewed.
  final String title;

  /// The callback when the title is pressed.
  final VoidCallback onTitlePressed;

  @override
  _DatePickerModeToggleButtonState createState() =>
      _DatePickerModeToggleButtonState();
}

class _DatePickerModeToggleButtonState
    extends State<_DatePickerModeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.mode == DatePickerMode.year ? 0.5 : 0,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_DatePickerModeToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode == widget.mode) {
      return;
    }

    if (widget.mode == DatePickerMode.year) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final controlColor = colorScheme.onSurface.withOpacity(0.60);

    return Container(
      padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
      height: _subHeaderHeight,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Semantics(
              label: 'Select year',
              excludeSemantics: true,
              button: true,
              child: SizedBox(
                height: _subHeaderHeight,
                child: InkWell(
                  onTap: widget.onTitlePressed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.subtitle2?.copyWith(
                              color: controlColor,
                            ),
                          ),
                        ),
                        RotationTransition(
                          turns: _controller,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: controlColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.mode == DatePickerMode.day)
            // Give space for the prev/next month buttons that are underneath this row
            const SizedBox(width: _monthNavButtonsWidth),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _MonthPicker extends StatefulWidget {
  /// Creates a month picker.
  _MonthPicker({
    Key? key,
    required this.initialMonth,
    required this.currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onChanged,
    required this.onDisplayedMonthChanged,
    this.onChildBuild,
    this.selectableDayPredicate,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        super(key: key);

  /// The initial month to display
  final DateTime initialMonth;

  final Widget Function(DateTime date)? onChildBuild;

  /// The current date.
  ///
  /// This date is subtly highlighted in the picker.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [lastDate].
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [firstDate].
  final DateTime lastDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// Called when the user navigates to a new month
  final ValueChanged<DateTime> onDisplayedMonthChanged;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate? selectableDayPredicate;

  @override
  State<StatefulWidget> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<_MonthPicker> {
  late DateTime _currentMonth;
  late DateTime _nextMonthDate;
  late DateTime _previousMonthDate;
  late PageController _pageController;
  late MaterialLocalizations _localizations;
  late TextDirection _textDirection;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth;
    _previousMonthDate = addMonthsToMonthDate(_currentMonth, -1);
    _nextMonthDate = addMonthsToMonthDate(_currentMonth, 1);
    _pageController = PageController(
      initialPage: monthDelta(
        widget.firstDate,
        _currentMonth,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleMonthPageChanged(int monthPage) {
    final monthDate = addMonthsToMonthDate(widget.firstDate, monthPage);
    if (_currentMonth.year != monthDate.year ||
        _currentMonth.month != monthDate.month) {
      _currentMonth = DateTime(monthDate.year, monthDate.month);
      _previousMonthDate = addMonthsToMonthDate(_currentMonth, -1);
      _nextMonthDate = addMonthsToMonthDate(_currentMonth, 1);
      widget.onDisplayedMonthChanged.call(_currentMonth);
    }
  }

  void _handleNextMonth() {
    if (!_isDisplayingLastMonth) {
      SemanticsService.announce(
        _localizations.formatMonthYear(_nextMonthDate),
        _textDirection,
      );
      _pageController.nextPage(
        duration: _monthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  void _handlePreviousMonth() {
    if (!_isDisplayingFirstMonth) {
      SemanticsService.announce(
        _localizations.formatMonthYear(_previousMonthDate),
        _textDirection,
      );
      _pageController.previousPage(
        duration: _monthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  /// True if the earliest allowable month is displayed.
  bool get _isDisplayingFirstMonth {
    return !_currentMonth.isAfter(
      DateTime(widget.firstDate.year, widget.firstDate.month),
    );
  }

  /// True if the latest allowable month is displayed.
  bool get _isDisplayingLastMonth {
    return !_currentMonth.isBefore(
      DateTime(widget.lastDate.year, widget.lastDate.month),
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    final month = addMonthsToMonthDate(widget.firstDate, index);
    return _DayPicker(
      key: ValueKey<DateTime>(month),
      selectedDate: widget.selectedDate,
      currentDate: widget.currentDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: month,
      selectableDayPredicate: widget.selectableDayPredicate,
      onChildBuild: widget.onChildBuild,
    );
  }

  @override
  Widget build(BuildContext context) {
    final previousTooltipText = '${_localizations.previousMonthTooltip} '
        '${_localizations.formatMonthYear(_previousMonthDate)}';
    final nextTooltipText = '${_localizations.nextMonthTooltip} '
        '${_localizations.formatMonthYear(_nextMonthDate)}';
    final controlColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.60);

    return Semantics(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
            height: _subHeaderHeight,
            child: Row(
              children: <Widget>[
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: controlColor,
                  tooltip: _isDisplayingFirstMonth ? null : previousTooltipText,
                  onPressed:
                      _isDisplayingFirstMonth ? null : _handlePreviousMonth,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: controlColor,
                  tooltip: _isDisplayingLastMonth ? null : nextTooltipText,
                  onPressed: _isDisplayingLastMonth ? null : _handleNextMonth,
                ),
              ],
            ),
          ),
          _DayHeaders(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: _buildItems,
              itemCount: monthDelta(widget.firstDate, widget.lastDate) + 1,
              scrollDirection: Axis.horizontal,
              onPageChanged: _handleMonthPageChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
class _DayPicker extends StatelessWidget {
  /// Creates a day picker.
  _DayPicker({
    Key? key,
    required this.currentDate,
    required this.displayedMonth,
    required this.firstDate,
    required this.lastDate,
    this.onChildBuild,
    required this.selectedDate,
    required this.onChanged,
    this.selectableDayPredicate,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  final Widget Function(DateTime date)? onChildBuild;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [lastDate].
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [firstDate].
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate? selectableDayPredicate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final dayStyle = textTheme.caption!;
    final enabledDayColor = colorScheme.onSurface.withOpacity(0.87);
    final disabledDayColor = colorScheme.onSurface.withOpacity(0.38);
    const selectedDayColor = Colors.white;
    const selectedDayBackground = S2BColors.secondaryColor;
    const todayColor = Colors.black;

    final year = displayedMonth.year;
    final month = displayedMonth.month;

    final daysInMonth = getDaysInMonth(year, month);
    final dayOffset = firstDayOffset(year, month, localizations);

    final dayItems = <Widget>[];
    var day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final dayToBuild = DateTime(year, month, day);
        final isDisabled = dayToBuild.isAfter(lastDate) ||
            dayToBuild.isBefore(firstDate) ||
            (selectableDayPredicate != null &&
                !selectableDayPredicate!(dayToBuild));

        BoxDecoration? decoration;
        var dayColor = enabledDayColor;
        final isSelectedDay = isSameDay(selectedDate, dayToBuild);
        if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a
          // contrasting text color.
          dayColor = selectedDayColor;
          decoration = const BoxDecoration(
            color: selectedDayBackground,
            shape: BoxShape.circle,
          );
        } else if (isDisabled) {
          dayColor = disabledDayColor;
        } else if (isSameDay(currentDate, dayToBuild)) {
          // The current day gets a different text color and a circle stroke
          // border.
          dayColor = todayColor;
          decoration = BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 1),
            shape: BoxShape.circle,
          );
        }

        Widget dayWidget = Column(
          children: [
            Container(
              decoration: decoration,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Center(
                  child: Text(
                    localizations.formatDecimal(day),
                    style: dayStyle.apply(color: dayColor),
                  ),
                ),
              ),
            ),
            if (!isDisabled)
              if (onChildBuild != null) onChildBuild!(dayToBuild)
          ],
        );

        if (isDisabled) {
          dayWidget = ExcludeSemantics(
            child: dayWidget,
          );
        } else {
          dayWidget = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(dayToBuild),
            child: Semantics(
              label: '${localizations.formatDecimal(day)}, '
                  '${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              excludeSemantics: true,
              child: dayWidget,
            ),
          );
        }

        dayItems.add(dayWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _monthPickerHorizontalPadding,
      ),
      child: GridView.custom(
        physics: const ClampingScrollPhysics(),
        gridDelegate: _dayPickerGridDelegate,
        childrenDelegate: SliverChildListDelegate(
          dayItems,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const columnCount = DateTime.daysPerWeek;
    final tileWidth = constraints.crossAxisExtent / columnCount;
    final tileHeight = math.min(
      _dayPickerRowHeight,
      constraints.viewportMainAxisExtent / _maxDayPickerRowCount,
    );
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

class _DayPickerGridDelegateV2 extends SliverGridDelegate {
  const _DayPickerGridDelegateV2();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const columnCount = DateTime.daysPerWeek;
    final tileWidth = constraints.crossAxisExtent / columnCount;
    final tileHeight = math.min(
      _dayPickerRowHeight / 1.8,
      constraints.viewportMainAxisExtent / _maxDayPickerRowCount,
    );
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegateV2 oldDelegate) => false;
}

const _DayPickerGridDelegate _dayPickerGridDelegate = _DayPickerGridDelegate();
const _DayPickerGridDelegateV2 _dayPickerGridDelegateV2 =
    _DayPickerGridDelegateV2();

class _DayHeaders extends StatelessWidget {
  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _getDayHeaders(
    TextStyle headerStyle,
    MaterialLocalizations localizations,
  ) {
    final result = <Widget>[];
    for (var i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final weekday = i.localWeekday;
      result.add(
        ExcludeSemantics(
          child: Center(
            child: Text(weekday, style: headerStyle),
          ),
        ),
      );
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dayHeaderStyle = theme.textTheme.caption!.apply(
      color: colorScheme.onSurface.withOpacity(0.60),
    );
    final localizations = MaterialLocalizations.of(context);
    final labels = _getDayHeaders(dayHeaderStyle, localizations);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _monthPickerHorizontalPadding,
      ),
      child: GridView.custom(
        shrinkWrap: true,
        gridDelegate: _dayPickerGridDelegateV2,
        childrenDelegate: SliverChildListDelegate(
          labels,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}

/// A scrollable list of years to allow picking a year.
class _YearPicker extends StatefulWidget {
  /// Creates a year picker.
  ///
  /// The [currentDate, [firstDate], [lastDate], [selectedDate], and [onChanged]
  /// arguments must be non-null. The [lastDate] must be after the [firstDate].
  _YearPicker({
    Key? key,
    required this.currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.selectedDate,
    required this.onChanged,
  })  : assert(!firstDate.isAfter(lastDate)),
        super(key: key);

  /// The current date.
  ///
  /// This date is subtly highlighted in the picker.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The initial date to center the year display around.
  final DateTime initialDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  @override
  _YearPickerState createState() => _YearPickerState();
}

class _YearPickerState extends State<_YearPicker> {
  late ScrollController scrollController;

  // The approximate number of years necessary to fill the available space.
  static const int minYears = 18;

  @override
  void initState() {
    super.initState();

    // Set the scroll position to approximately center the initial year.
    final initialYearIndex = widget.selectedDate.year - widget.firstDate.year;
    final initialYearRow = initialYearIndex ~/ _yearPickerColumnCount;
    // Move the offset down by 2 rows to approximately center it.
    final centeredYearRow = initialYearRow - 2;
    final scrollOffset =
        _itemCount < minYears ? 0.0 : centeredYearRow * _yearPickerRowHeight;
    scrollController = ScrollController(initialScrollOffset: scrollOffset);
  }

  Widget _buildYearItem(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Backfill the _YearPicker with disabled years if necessary.
    final offset = _itemCount < minYears ? (minYears - _itemCount) ~/ 2 : 0;
    final year = widget.firstDate.year + index - offset;
    final isSelected = year == widget.selectedDate.year;
    final isCurrentYear = year == widget.currentDate.year;
    final isDisabled =
        year < widget.firstDate.year || year > widget.lastDate.year;
    const decorationHeight = 36.0;
    const decorationWidth = 72.0;

    Color textColor;
    if (isSelected) {
      textColor = colorScheme.onPrimary;
    } else if (isDisabled) {
      textColor = colorScheme.onSurface.withOpacity(0.38);
    } else if (isCurrentYear) {
      textColor = colorScheme.primary;
    } else {
      textColor = colorScheme.onSurface.withOpacity(0.87);
    }
    final itemStyle = textTheme.bodyText1?.apply(color: textColor);

    BoxDecoration? decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(decorationHeight / 2),
        shape: BoxShape.rectangle,
      );
    } else if (isCurrentYear && !isDisabled) {
      decoration = BoxDecoration(
        border: Border.all(
          color: colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(decorationHeight / 2),
        shape: BoxShape.rectangle,
      );
    }

    Widget yearItem = Center(
      child: Container(
        decoration: decoration,
        height: decorationHeight,
        width: decorationWidth,
        child: Center(
          child: Semantics(
            selected: isSelected,
            child: Text(year.toString(), style: itemStyle),
          ),
        ),
      ),
    );

    if (isDisabled) {
      yearItem = ExcludeSemantics(
        child: yearItem,
      );
    } else {
      yearItem = InkWell(
        key: ValueKey<int>(year),
        onTap: () {
          widget.onChanged(
            DateTime(
              year,
              widget.initialDate.month,
              widget.initialDate.day,
            ),
          );
        },
        child: yearItem,
      );
    }

    return yearItem;
  }

  int get _itemCount {
    return widget.lastDate.year - widget.firstDate.year + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            gridDelegate: _yearPickerGridDelegate,
            itemBuilder: _buildYearItem,
            itemCount: math.max(_itemCount, minYears),
            padding: const EdgeInsets.symmetric(horizontal: _yearPickerPadding),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _YearPickerGridDelegate extends SliverGridDelegate {
  const _YearPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final tileWidth = (constraints.crossAxisExtent -
            (_yearPickerColumnCount - 1) * _yearPickerRowSpacing) /
        _yearPickerColumnCount;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: _yearPickerRowHeight,
      crossAxisCount: _yearPickerColumnCount,
      crossAxisStride: tileWidth + _yearPickerRowSpacing,
      mainAxisStride: _yearPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_YearPickerGridDelegate oldDelegate) => false;
}

const _YearPickerGridDelegate _yearPickerGridDelegate =
    _YearPickerGridDelegate();

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Common date utility functions used by the date picker implementation

// NOTE: This is an internal implementation file. Even though there are public
// classes and functions defined here, they are only meant to be used by the
// date picker implementation and are not exported
//as part of the Material library.
// See pickers.dart for exactly what is considered part of the public API.

//import '../material_localizations.dart';

/// Returns a [DateTime] with just the date of the original, but no time set.
DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

/// Returns true if the two [DateTime] objects have the same day, month, and
/// year.
bool isSameDay(DateTime dateA, DateTime dateB) {
  return dateA.year == dateB.year &&
      dateA.month == dateB.month &&
      dateA.day == dateB.day;
}

/// Determines the number of months between two [DateTime] objects.
///
/// For example:
/// ```
/// DateTime date1 = DateTime(year: 2019, month: 6, day: 15);
/// DateTime date2 = DateTime(year: 2020, month: 1, day: 15);
/// int delta = monthDelta(date1, date2);
/// ```
///
/// The value for `delta` would be `7`.
int monthDelta(DateTime startDate, DateTime endDate) {
  return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
}

/// Returns a [DateTime] with the added number of months and truncates any day
/// and time information.
///
/// For example:
/// ```
/// DateTime date = DateTime(year: 2019, month: 1, day: 15);
/// DateTime futureDate = _addMonthsToMonthDate(date, 3);
/// ```
///
/// `date` would be January 15, 2019.
/// `futureDate` would be April 1, 2019 since it adds 3 months and truncates
/// any additional date information.
DateTime addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
  return DateTime(monthDate.year, monthDate.month + monthsToAdd);
}

/// Computes the offset from the first day of the week that the first day of
/// the [month] falls on.
///
/// For example, September 1, 2017 falls on a Friday, which in the calendar
/// localized for United States English appears as:
///
/// ```
/// S M T W T F S
/// _ _ _ _ _ 1 2
/// ```
///
/// The offset for the first day of the months is the number of leading blanks
/// in the calendar, i.e. 5.
///
/// The same date localized for the Russian calendar has a different offset,
/// because the first day of week is Monday rather than Sunday:
///
/// ```
/// M T W T F S S
/// _ _ _ _ 1 2 3
/// ```
///
/// So the offset is 4, rather than 5.
///
/// This code consolidates the following:
///
/// - [DateTime.weekday] provides a 1-based index into days of week, with 1
///   falling on Monday.
/// - [MaterialLocalizations.firstDayOfWeekIndex] provides a 0-based index
///   into the [MaterialLocalizations.narrowWeekdays] list.
/// - [MaterialLocalizations.narrowWeekdays] list provides localized names of
///   days of week, always starting with Sunday and ending with Saturday.
int firstDayOffset(int year, int month, MaterialLocalizations localizations) {
  // 0-based day of week for the month and year, with 0 representing Monday.
  final weekdayFromMonday = DateTime(year, month).weekday - 1;

  // 0-based start of week depending on the locale, with 0 representing Sunday.
  var firstDayOfWeekIndex = localizations.firstDayOfWeekIndex;

  // firstDayOfWeekIndex recomputed to be Monday-based, in order to compare with
  // weekdayFromMonday.
  firstDayOfWeekIndex = (firstDayOfWeekIndex - 1) % 7;

  // Number of days between the first day of week appearing on the calendar,
  // and the day corresponding to the first of the month.
  return (weekdayFromMonday - firstDayOfWeekIndex) % 7;
}

/// Returns the number of days in a month, according to the proleptic
/// Gregorian calendar.
///
/// This applies the leap year logic introduced by the Gregorian reforms of
/// 1582. It will not give valid results for dates prior to that time.
int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  const daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysInMonth[month - 1];
}
