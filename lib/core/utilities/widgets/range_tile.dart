import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class RangeTile extends StatelessWidget {
  RangeTile(
      { this.title,
      required this.onChanged,
      this.doubleSlider = false,
      required this.values,
      this.value = 5,
      required this.max,
      required this.min});

  final Function(dynamic) onChanged;
  final String? title;

  final bool doubleSlider;
  final RangeValues values;
  final double value;
  final double max;
  final double min;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
         height: _size.height * 0.06,
        // width: double.maxFinite,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
         // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Text(
            //   title,
            //   textAlign: TextAlign.start,
            //   style: const TextStyle(
            //       color: Colors.black,
            //       letterSpacing: 0.0,
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.w700),
            // ),
            // Text(
            //   doubleSlider
            //       ? '${values.start.round()}-${values.end.round()}'
            //       : '${value.round()}km',
            //   textAlign: TextAlign.end,
            //   style: const TextStyle(
            //       color: Colors.grey,
            //       letterSpacing: 0.0,
            //       fontSize: 14.0,
            //       fontWeight: FontWeight.w700),
            // ),
        //  ]),
          doubleSlider
              ? Expanded(
                  child: RangeSlider(
                    activeColor: Palette.primaryColor,
                    inactiveColor: Palette.primaryColor.withOpacity(0.1),
                    values: values,
                    max: max,
                    min: min,
                    onChanged: onChanged
                  ),
                )
              : Slider(
                  activeColor: Palette.primaryColor,
                  inactiveColor: Palette.primaryColor.withOpacity(0.1),
                  value: value,
                  min: min,
                  max: max,
                  onChanged: onChanged,
                ),
        ]));
  }
}
