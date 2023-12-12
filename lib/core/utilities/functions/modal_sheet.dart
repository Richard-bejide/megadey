import 'package:flutter/material.dart';

import '../widgets/bottomsheet_drag_button.dart';

Future modalSheetWidget(
    {required BuildContext context,
    required Widget content,
    Widget title = const SizedBox(),
    Widget subtitle = const SizedBox()}) {

  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
      ),
      context: context,

      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {

          return Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 5, right: 10, left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               BottomsheetDragButton(),
                const SizedBox(height: 25.0),
                SizedBox(
                  width: 200,
                  child: Center(
                    child: title,
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 200,
                  child: Center(
                    child: subtitle,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
                  child: content,
                ),
              ],
            ),
          );
        });
      });
}
