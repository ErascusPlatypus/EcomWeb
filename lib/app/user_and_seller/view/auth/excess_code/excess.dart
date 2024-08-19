// Widget loginForm = Container(
//   height: 280,
//   width: 380,
//   constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
//   child: Stack(
//     children: <Widget>[
//       Container(
//         height: 180,
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(255, 255, 255, 0.8),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10),
//             bottomLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//             bottomRight: Radius.circular(10),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 0.0),
//               child: TextField(
//                 controller: email,
//                 style: TextStyle(fontSize: 16.0),
//                 decoration: InputDecoration(
//                     fillColor: Colors.grey.shade100,
//                     filled: true,
//                     hintText: "email",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: TextField(
//                 controller: password,
//                 style: TextStyle(fontSize: 16.0),
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     fillColor: Colors.grey.shade100,
//                     filled: true,
//                     hintText: "Password",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//       loginButton,
//     ],
//   ),
// );