import 'package:flutter/material.dart';
import 'package:sipalaya_ecommerce/presentation/SecondaryScreen/HomeScreen/components/HomePageHeader.dart';


class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
         SizedBox(height: 40,),
          HomePageHeader()
        ],
      )
    );
  }
}
