import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

class DateRangePicker extends StatefulWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String startDateLabel;
  final String endDateLabel;
  final Locale locale;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueSetter<DateTime>? onStartDateChanged;
  final ValueSetter<DateTime>? onEndDateChanged;

  DateRangePicker({
    required this.startDateController,
    required this.endDateController,
    required this.startDateLabel,
    required this.endDateLabel,
    Locale? locale,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    this.onStartDateChanged,
    this.onEndDateChanged,
  })  : locale = locale ?? const Locale("en"),
        initialDate = initialDate ?? DateTime.now(),
        firstDate = firstDate ?? DateTime(2000),
        lastDate = lastDate ?? DateTime(2101);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.startDateController,
              decoration: styles.inputDecoration.copyWith(
                suffix: Icon(getIcon('calendar')),
                label: Text(widget.startDateLabel.tr),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  locale: widget.locale,
                  initialDate: widget.initialDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  // Additional parameters...
                );
                if (pickedDate != null) {
                  // String formattedDate = dateFormatter.format(pickedDate);
                  String formattedDateDisplay =
                      dateFormatterDisplay.format(pickedDate);
                  setState(() {
                    widget.startDateController.text = formattedDateDisplay;
                    // print(formattedDate);
                  });
                  widget.onStartDateChanged?.call(pickedDate);
                }
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: widget.endDateController,
              decoration: styles.inputDecoration.copyWith(
                suffix: Icon(getIcon('calendar')),
                label: Text(widget.endDateLabel.tr),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  locale: widget.locale,
                  initialDate: widget.initialDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  // Additional parameters...
                );
                if (pickedDate != null) {
                  // String formattedDate = dateFormatter.format(pickedDate);
                  String formattedDateDisplay =
                      dateFormatterDisplay.format(pickedDate);
                  setState(() {
                    widget.endDateController.text = formattedDateDisplay;
                    // print(formattedDate);
                  });
                  widget.onEndDateChanged?.call(pickedDate);
                }
              },
               
            ),
          ),
        ],
      ),
    );
  }
}
