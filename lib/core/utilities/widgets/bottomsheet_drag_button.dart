import 'package:flutter/material.dart';

class BottomsheetDragButton extends StatelessWidget {
  const BottomsheetDragButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          width: 75.0,
          height: 3.0,
        ),
      ),
    );
  }
}

// class BottomsheetDragButton extends StatelessWidget {
//   const BottomsheetDragButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Center(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[600],
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//             ),
//           ),
//           width: 55.0,
//           height: 13.0,
//           alignment: Alignment.center,
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(10.0),
//               bottomRight: Radius.circular(10.0),
//               topLeft: Radius.circular(30.0),
//               topRight: Radius.circular(30.0),
//             ),
//             child: Container(
//               alignment: Alignment.topCenter,
//               height: 6.0,
//               width: 30.0,
//               color: Theme.of(context).brightness == Brightness.light
//                   ? Colors.white
//                   : Colors.white,
//             ),
//           ),
//         ),
//       );
//   }
// }
