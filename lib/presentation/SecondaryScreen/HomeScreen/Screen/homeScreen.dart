// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class Body extends StatelessWidget {
//
//
//   Future<Map<String, String>> getuserData() async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String email = prefs.getString('email')??"";
//     final String name = prefs.getString('name')??'';
//     final String phonenumber = prefs.getString('phonenumber')??'';
//     return {
//       'email':email,
//       'name':name,
//       'phonenumber':phonenumber
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 200,),
//         Text("this is my homepage")],
//     );
//   }
// }
