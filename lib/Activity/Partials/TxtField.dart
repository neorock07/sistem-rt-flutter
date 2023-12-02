// Widget TxtField(BuildContext context,
//       {GlobalKey? key,
//       String? label,
//       String? init,
//       TextInputType? keyboardType,
//       TextEditingController? controller}) {
//     return Padding(
//       padding: EdgeInsets.only(left: 5.w, right: 5.w),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           TextField(
//             // initialValue: init,
//             controller: controller,
//             textCapitalization: TextCapitalization.characters,
//             keyboardType:
//                 (keyboardType != null) ? keyboardType : TextInputType.text,
//             decoration: InputDecoration(
//                 label: Text("$label"),
//                 suffixIcon: IconButton(
//                     onPressed: () {
//                       controller!.text = txtClearController.Clear();
//                     },
//                     icon: const Icon(Icons.clear, color: Colors.grey))),
//           )
//         ],
//       ),
//     );
//   }