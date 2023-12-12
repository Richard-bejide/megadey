import 'package:flutter/material.dart';

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
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          width: 50.0,
                          height: 6.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Center(child: title),
                    const SizedBox(height: 10.0),
                    Center(child: subtitle),
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
