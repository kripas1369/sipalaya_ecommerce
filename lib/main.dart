import 'package:flutter/material.dart';
import 'package:sipalaya_ecommerce/presentation/PrimaryScreen/SplaschScreen/body.dart';
import 'package:sipalaya_ecommerce/presentation/SecondaryScreen/HomeScreen/body.dart';
import 'package:sipalaya_ecommerce/test.dart';

import 'presentation/SecondaryScreen/CustomBottomNavBar/custombottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomBottomNavBar(),
      // home:ImageSlider()
    );
  }
}
