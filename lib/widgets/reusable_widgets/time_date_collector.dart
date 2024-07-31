import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/utilts/string.dart';

final fontHelper = FontHelper();

class TimeDateCollector extends StatefulWidget {
  const TimeDateCollector(
      {super.key,
      required this.onSelDate,
      this.onSelTime,
      this.timeTracker,
      this.lableColor,
      this.firstDates,
      this.lastDates});
  final void Function(String date) onSelDate;
  final void Function(String time)? onSelTime;
  final bool? timeTracker;
  final Color? lableColor;
  final DateTime? firstDates;
  final DateTime? lastDates;

  @override
  State<TimeDateCollector> createState() => _TimeDateCollectorState();
}

class _TimeDateCollectorState extends State<TimeDateCollector> {
  String selectDate = "Select Date : ";
  String selectTime = "Select Time : ";
  void _datePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDates ?? DateTime.now(),
      lastDate: widget.lastDates ?? DateTime(2045),
    );
    if (date != null) {
      setState(() {
        selectDate = formatedDate(date);
      });
      widget.onSelDate(selectDate);
    }
  }

  void _timePicker() async {
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectTime = time.format(context);
      });
      if (widget.timeTracker == null || widget.timeTracker == true) {
        widget.onSelTime!(selectTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectDate,
                style: fontHelper
                    .bodyMedium(context)
                    .copyWith(color: widget.lableColor ?? Colors.white),
              ),
              const Gap(largeGap),
              ElevatedButton(
                  onPressed: _datePicker,
                  child: const FaIcon(
                    FontAwesomeIcons.solidCalendar,
                    color: Colors.orange,
                  )),
            ],
          ),
        ),
        Visibility(
          visible: widget.timeTracker ?? true,
          child: Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectTime,
                style: fontHelper
                    .bodyMedium(context)
                    .copyWith(color: Colors.white),
              ),
              const Gap(largeGap),
              ElevatedButton(
                  onPressed: _timePicker,
                  child: const FaIcon(
                    FontAwesomeIcons.solidClock,
                    color: Colors.greenAccent,
                  )),
            ],
          )),
        ),
      ],
    );
  }
}