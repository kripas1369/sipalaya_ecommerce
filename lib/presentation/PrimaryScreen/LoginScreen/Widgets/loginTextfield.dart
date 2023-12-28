import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sipalaya_ecommerce/core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:sipalaya_ecommerce/presentation/SecondaryScreen/HomeScreen/body.dart';
import '../../../../../widgets/customTextfieldWidget.dart';
import '../../RegisterScreen/body.dart';
import '../../Widgets/primaryText.dart';
import '../../Widgets/sizeBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginTextfield extends StatefulWidget {
  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  final TextEditingController emailController = TextEditingController(text: "kripas@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "Flutter1234");



  final String loginUrl = "${ApiUrls.baseurl}api/user/login/";


  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      print('Error in checkLogin: $e');
    }
  }




  Future<void> loginUser() async{
    Map<String, dynamic> requestBody ={
      "email":emailController.text.toString(),
      "password":passwordController.text.toString(),
    };
    final response = await http.post(Uri.parse(loginUrl),
        headers: {"Content-Type":"application/json"},
        body:json.encode(requestBody)
  );
    if (response.statusCode==200){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.body)['token']['access']);
      print(response.body);
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Succes',
        desc:jsonDecode(response.body)["msg"].toString(),
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
      print(jsonDecode(response.body)["msg"].toString());
    }else if
    (response.statusCode==400){
      print(response.body);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: "Error",
        desc:
        jsonDecode(response.body)["non_field_errors"].toString(),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }else if
    (response.statusCode==500){
      print(response.body);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: "Api Error",
        desc:"",
        // jsonDecode(response.body),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
    else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: "Server error",
        desc:
        jsonDecode(response.body),
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            controller: emailController,
            decoration: customDecoration(hintText: "Email")),
        TextSizeBox(),
        TextFormField(
            controller: passwordController,
            decoration: customDecoration(hintText: "Password")),
        TextSizeBox(),
        Row(
          children: [
            Spacer(),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                loginUser();
              },
              child: Text("Login"),
            ),
            Spacer(),
            CustomText(
              text: "Forgot Password",
            ),
            Spacer(),
          ],
        ),

        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: CustomText(
            text: "Register Now",
          ),
        ),
      ],
    );
  }
}
