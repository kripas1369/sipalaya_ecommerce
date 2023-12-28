import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  Future<Map<String, String>> getuserData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email')??"";
    final String name = prefs.getString('name')??'';
    final String phonenumber = prefs.getString('phonenumber')??'';
    return {
      'email':email,
      'name':name,
      'phonenumber':phonenumber
    };
  }

  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getuserData(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          } else if (snapshot.hasError){
            return Text("Error:${snapshot.error}");
          }
          else{
            final userData = snapshot.data!;
            return Scaffold(
              body: Column(
              children: [
                Text('email is ${userData['email']}'),
                 Text('Name is ${userData['name']}'),
                 Text('number is ${userData['phonenumber']}'),
              ],
              ),
            );
          }

    }
    );
  }
}
