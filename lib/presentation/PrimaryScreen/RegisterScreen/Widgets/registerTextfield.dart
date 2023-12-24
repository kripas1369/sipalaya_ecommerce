import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sipalaya_ecommerce/core/network/network_info.dart';
import '../../../../../widgets/customTextfieldWidget.dart';
import '../../../../../widgets/defaultButton.dart';
import '../../LoginScreen/body.dart';
import '../../Widgets/primaryText.dart';
import '../../Widgets/sizeBox.dart';
import 'package:http/http.dart' as http;

class RegisterTextfield extends StatefulWidget {
  const RegisterTextfield({super.key});

  @override
  State<RegisterTextfield> createState() => _RegisterTextfieldState();
}

class _RegisterTextfieldState extends State<RegisterTextfield> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController(text:"kripask50@gmail.com");
    final TextEditingController passwordController = TextEditingController(text: "Flutter1234");
    final TextEditingController conformpasswordController = TextEditingController(text: "Flutter1234");
    final TextEditingController nameController = TextEditingController(text: "kripas");
    final TextEditingController numberController = TextEditingController(text: "9860486264");
    final formKey = GlobalKey<FormState>();
    final String registerUrl = "${ApiUrls.baseurl}api/user/register/";

    Future<void> postData() async{
      Map<String, dynamic> requestBody = {
        "email":emailController.text.toString(),
        "name":nameController.text.toString(),
        "password":passwordController.text.toString(),
        "password2":conformpasswordController.text.toString(),
        "phone_number":numberController.text.toString(),
        "tc":"True"
      };

      final response = await http.post(Uri.parse(registerUrl),
        headers:{'Content-Type':"application/json"},
        body:json.encode(requestBody)
      );
      if(response.statusCode == 201){
        print("^^^^^^^^^^^^");
        print(response.body);
        print(jsonDecode(response.body)["msg"].toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }else{
        print("^^^^^^^^^^^^");
        print(jsonDecode(response.body)["errror"].toString());
      }
    }
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // autocorrect: true,
            autofocus: true,
            showCursor: true,
            // textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: emailController,
            cursorColor: Colors.red,
            // cursorRadius: Radius.circular(20),
            // cursorWidth: 100.3,
            decoration: customDecoration(hintText: "Email"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
          ),
          TextSizeBox(),
          TextFormField(
            textInputAction: TextInputAction.next,
            maxLines: 1,

            ///Task
            //AutoExpandTextfield
            controller: nameController,
            decoration: customDecoration(hintText: "Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
          ),
          TextSizeBox(),
          TextFormField(
            textInputAction: TextInputAction.next,
            maxLength: 10,

            ///Task
            // validate the number wiht out 0/10"
            /// Task
            keyboardType: TextInputType.number,
            controller: numberController,
            decoration: customDecoration(hintText: "Mobile Number"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your mobile number";
              }
              return null;
            },
          ),
          TextSizeBox(),
          TextFormField(
            textInputAction: TextInputAction.next,
            obscureText: true,

            ///Task change this dot on password obscuretext with #####
            controller: passwordController,
            decoration: customDecoration(hintText: "Password"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          TextSizeBox(),
          TextFormField(
            controller: conformpasswordController,
            decoration: customDecoration(hintText: "Conform Password"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          TextSizeBox(),
          InkWell(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  print("clickeddddd");
                  postData();
                  print("clickeddddd");

                } else {}
              },
              child: DefaultButton()),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: CustomText(
                  text: "Already have an account?",
                ),
              ),
              Spacer(),
              CustomText(
                text: "Forgot Passwords",
              ),
              Spacer(),
            ],
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
