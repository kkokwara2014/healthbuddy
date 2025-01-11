// import 'package:flutter/material.dart';
// import 'package:health_buddy/constants/color.dart';

// class MyButton extends StatelessWidget {
//   const MyButton(
//       {super.key, required this.text, this.onTap, required this.color});
//   final String text;
//   final VoidCallback? onTap;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//         onTap: onTap,
//         child: Container(
//           width: size.width,
//           height: 52,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 color: whiteColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
