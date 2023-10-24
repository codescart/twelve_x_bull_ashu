// import 'package:flutter/material.dart';
//
// class TextFieldW extends StatefulWidget {
//   TextInputType? keyboardType;
//   String text;
//   IconData? prefixicon;
//   TextEditingController? controller;
//   int? maxLength;
//
//   TextFieldW(
//       {Key? key,
//       this.keyboardType,
//       this.maxLength,
//       this.controller,
//       this.prefixicon,
//       required this.text})
//       : super(key: key);
//
//   @override
//   State<TextFieldW> createState() => _TextFieldWState();
// }
//
// class _TextFieldWState extends State<TextFieldW> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
//             child: Text(
//               widget.text!,
//               style: TextStyle(fontSize: 15, color: Colors.white),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//             child: TextFormField(
//               controller: widget.controller,
//               keyboardType: widget.keyboardType,
//               maxLength: widget.maxLength,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//               ),
//               cursorColor: Colors.white,
//               decoration: InputDecoration(
//                 counterText: "",
//                 contentPadding: EdgeInsets.only(bottom: 5,left: 15),
//                 filled: true,
//                 // fillColor: Color(0xffe4f2fd),
//                 suffixIcon: Icon(
//                   widget.prefixicon,
//                   color: Colors.white,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Colors.white),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Colors.white),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
