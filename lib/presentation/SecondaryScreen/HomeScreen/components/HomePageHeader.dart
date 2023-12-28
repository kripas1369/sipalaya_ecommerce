import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../../core/network/network_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HomePageHeader extends StatefulWidget {
  const HomePageHeader({super.key});

  @override
  State<HomePageHeader> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  ///Service Code
  List<Map<String, dynamic>> sliders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${ApiUrls.baseurl}/products/api/sliders/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        sliders = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // Handle error
      print('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: sliders.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Image.network(sliders[index]['image'], fit: BoxFit.cover);
          },
          options: CarouselOptions(
            viewportFraction: 0.5,
            autoPlayCurve: Curves.bounceOut,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayInterval:  Duration(seconds: 1),
            autoPlay: true,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
