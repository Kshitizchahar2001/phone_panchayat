// ignore_for_file: dead_code, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';

import '../src/date.dart';
import '../src/date_format.dart';
import '../src/date_hint.dart';
import '../src/date_util.dart';
import '../src/nullable_valid_date.dart';
import '../src/valid_date.dart';

class DropdownDatePickerData {
  /// Stores the date format how [DropdownButton] widgets should be build.
  final DateFormat dateFormat;

  /// Mimimum date value that [DropdownButton] widgets can have.
  final ValidDate firstDate;

  /// Maximum date value that [DropdownButton] widgets can have.
  final ValidDate lastDate;

  /// Text style of the dropdown button and it's menu items
  final TextStyle textStyle;

  /// The widget.dropdownDatePickerData to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 2.0 height bottom container with Theme.of(context).primaryColor
  final Widget underLine;

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used instead.
  final Color dropdownColor;

  /// If true [DropdownMenuItem]s will be built in ascending order
  final bool ascending;

  /// Contains year, month and day DropdownButton's hint texts
  ///
  /// Default is: 'yyyy', 'mm', 'dd'
  final DateHint dateHint;

  Date _currentDate;

  /// Holds the currently selected date
  Date get currentDate => _currentDate;

  /// Returns currently selected day
  int get day {
    return _currentDate?.day;
  }

  /// Returns currently selected month
  int get month {
    return _currentDate?.month;
  }

  /// Returns currently selected year
  int get year {
    return _currentDate?.year;
  }

  /// Returns date as String by a [separator]
  /// based on [dateFormat]
  String getDate([String separator = '-']) {
    String date;
    var year = _currentDate?.year;
    var month = Date.toStringWithLeadingZeroIfLengthIsOne(_currentDate?.month);
    var day = Date.toStringWithLeadingZeroIfLengthIsOne(_currentDate?.day);

    switch (dateFormat) {
      case DateFormat.ymd:
        date = '$year$separator$month$separator$day';
        break;
      case DateFormat.dmy:
        date = '$day$separator$month$separator$year';
        break;
      case DateFormat.mdy:
        date = '$month$separator$day$separator$year';
        break;
    }
    return date;
  }

  static bool _isValidInitialDate(Date date, Date firstDate, Date lastDate) {
    return true;
    if (date?.year == null) return true;
    if (date.year < firstDate.year) return false;
    if (date.year > lastDate.year) return false;
    if (date?.month == null) return true;
    if (date.month < firstDate.month) return false;
    if (date.month > lastDate.month) return false;
    if (date?.day == null) return true;
    if (date.day < firstDate.day) return false;
    if (date.day > lastDate.day) return false;
  }

  DropdownDatePickerData({
    @required this.firstDate,
    @required this.lastDate,
    Date initialDate = const NullableValidDate.nullDate(),
    this.dateFormat = DateFormat.ymd,
    this.dateHint = const DateHint(),
    this.dropdownColor,
    this.textStyle,
    this.underLine,
    this.ascending = true,
    final Key key,
  })  : assert(firstDate < lastDate, 'First date must be before last date.'),
        assert(_isValidInitialDate(initialDate, firstDate, lastDate),
            'Initial date must be null or between first and last date.'),
        _currentDate = initialDate;
}

/// Creates a [DropdownDatePicker] widget.dropdownDatePickerData instance
///
/// Displays year, month and day [DropdownButton] widgets in a [Row]
// ignore: must_be_immutable
class DropdownDatePicker extends StatefulWidget {
  /// Creates an instance of [DropdownDatePicker].
  ///
  /// [firstDate] must be before [lastDate]
  /// and [initialDate] must be between their range
  ///
  /// [initialDate] is optional, if not provided a hintText
  /// will be shown in their [DropDownButton]'s
  ///
  /// By default [dateFormat] is [DateFormat.ymd].
  ///

  final DropdownDatePickerData dropdownDatePickerData;

  DropdownDatePicker({this.dropdownDatePickerData});

  @override
  _DropdownDatePickerState createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  List<DropdownMenuItem<int>> _buildDropdownMenuItemList(int min, int max) {
    return _intGenerator(min, max, widget.dropdownDatePickerData.ascending)
        .map(
          (i) => DropdownMenuItem<int>(
            value: i,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                Date.toStringWithLeadingZeroIfLengthIsOne(i),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 14),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildDropdownButton({
    @required final int initialValue,
    @required final String hint,
    @required final Function onChanged,
    @required final List<DropdownMenuItem<int>> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButton<int>(
        dropdownColor: widget.dropdownDatePickerData.dropdownColor,
        underline: widget.dropdownDatePickerData.underLine ??
            Container(
              color: Theme.of(context).primaryColor,
              height: 2,
            ),
        value: initialValue,
        hint: Text(
          hint, // dd, mm, yyyy
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 14),
        ),
        onChanged: (val) => Function.apply(onChanged, [val]),
        items: items,
      ),
    );
  }

  Iterable<int> _intGenerator(int start, int end, bool ascending) sync* {
    if (ascending) {
      for (var i = start; i <= end; i++) {
        yield i;
      }
    } else {
      for (var i = end; i >= start; i--) {
        yield i;
      }
    }
  }

  Widget _buildYearDropdownButton() {
    return _buildDropdownButton(
      items: _buildDropdownMenuItemList(
        widget.dropdownDatePickerData.firstDate.year,
        widget.dropdownDatePickerData.lastDate.year,
      ),
      initialValue: widget.dropdownDatePickerData._currentDate?.year,
      hint: widget.dropdownDatePickerData.dateHint.year,
      onChanged: (final year) => setState(() =>
          widget.dropdownDatePickerData._currentDate =
              widget.dropdownDatePickerData._currentDate.copyWith(year: year)),
    );
  }

  Widget _buildMonthDropdownButton() {
    var minMonth = 1;
    var maxMonth = 12;

    if (widget.dropdownDatePickerData._currentDate?.year != null) {
      if (widget.dropdownDatePickerData.firstDate.year ==
          widget.dropdownDatePickerData._currentDate?.year) {
        minMonth = widget.dropdownDatePickerData.firstDate.month;
        if (widget.dropdownDatePickerData._currentDate?.month != null &&
            widget.dropdownDatePickerData._currentDate.month <
                widget.dropdownDatePickerData.firstDate.month) {
          widget.dropdownDatePickerData._currentDate = widget
              .dropdownDatePickerData._currentDate
              .copyWith(month: minMonth);
        }
      }
      if (widget.dropdownDatePickerData.lastDate.year ==
          widget.dropdownDatePickerData._currentDate?.year) {
        maxMonth = widget.dropdownDatePickerData.lastDate.month;
        if (widget.dropdownDatePickerData._currentDate?.month != null &&
            widget.dropdownDatePickerData._currentDate.month >
                widget.dropdownDatePickerData.lastDate.month) {
          widget.dropdownDatePickerData._currentDate = widget
              .dropdownDatePickerData._currentDate
              .copyWith(month: maxMonth);
        }
      }
    } else {
      widget.dropdownDatePickerData._currentDate = widget
          .dropdownDatePickerData._currentDate
          .copyWith(month: widget.dropdownDatePickerData._currentDate?.month);
    }
    return _buildDropdownButton(
      items: _buildDropdownMenuItemList(
        minMonth,
        maxMonth,
      ),
      initialValue: widget.dropdownDatePickerData._currentDate?.month,
      hint: widget.dropdownDatePickerData.dateHint.month,
      onChanged: (final month) => setState(() => widget
              .dropdownDatePickerData._currentDate =
          widget.dropdownDatePickerData._currentDate.copyWith(month: month)),
    );
  }

  Widget _buildDayDropdownButton() {
    var minDay = 1;
    var maxDay = DateUtil.daysInDate(
      month: widget.dropdownDatePickerData._currentDate?.month,
      year: widget.dropdownDatePickerData._currentDate?.year,
    );

    if (widget.dropdownDatePickerData._currentDate?.month != null) {
      if (widget.dropdownDatePickerData._currentDate?.year != null) {
        if (widget.dropdownDatePickerData.firstDate.year ==
                widget.dropdownDatePickerData._currentDate?.year &&
            widget.dropdownDatePickerData.firstDate.month >=
                widget.dropdownDatePickerData._currentDate?.month) {
          minDay = widget.dropdownDatePickerData.firstDate.day;
          if (widget.dropdownDatePickerData._currentDate.day != null &&
              widget.dropdownDatePickerData.firstDate.day >=
                  widget.dropdownDatePickerData._currentDate?.day) {
            widget.dropdownDatePickerData._currentDate = widget
                .dropdownDatePickerData._currentDate
                .copyWith(day: minDay);
          }
        }
        if (widget.dropdownDatePickerData.lastDate.year ==
                widget.dropdownDatePickerData._currentDate?.year &&
            widget.dropdownDatePickerData.lastDate.month <=
                widget.dropdownDatePickerData._currentDate?.month) {
          maxDay = widget.dropdownDatePickerData.lastDate.day;
          if (widget.dropdownDatePickerData._currentDate.day != null &&
              widget.dropdownDatePickerData.lastDate.day <=
                  widget.dropdownDatePickerData._currentDate?.day) {
            widget.dropdownDatePickerData._currentDate = widget
                .dropdownDatePickerData._currentDate
                .copyWith(day: maxDay);
          }
        }
      }
    }

    return _buildDropdownButton(
      items: _buildDropdownMenuItemList(minDay, maxDay),
      initialValue: widget.dropdownDatePickerData._currentDate?.day,
      hint: widget.dropdownDatePickerData.dateHint.day,
      onChanged: (final day) => setState(() =>
          widget.dropdownDatePickerData._currentDate =
              widget.dropdownDatePickerData._currentDate.copyWith(day: day)),
    );
  }

  List<Widget> _buildDropdownButtonsByDateFormat() {
    final dropdownButtonList = <Widget>[];

    switch (widget.dropdownDatePickerData.dateFormat) {
      case DateFormat.dmy:
        dropdownButtonList
          ..add(_buildDayDropdownButton())
          ..add(_buildMonthDropdownButton())
          ..add(_buildYearDropdownButton());
        break;
      case DateFormat.ymd:
        dropdownButtonList
          ..add(_buildYearDropdownButton())
          ..add(_buildMonthDropdownButton())
          ..add(_buildDayDropdownButton());
        break;
      case DateFormat.mdy:
        dropdownButtonList
          ..add(_buildMonthDropdownButton())
          ..add(_buildDayDropdownButton())
          ..add(_buildYearDropdownButton());
        break;
    }
    return dropdownButtonList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildDropdownButtonsByDateFormat(),
    );
  }
}
