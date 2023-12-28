import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sipalaya_ecommerce/core/network/network_info.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Slider'),
      ),
      body: sliders.isNotEmpty
          ? CarouselSlider.builder(
        itemCount: sliders.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Image.network(sliders[index]['image'], fit: BoxFit.cover);
        },
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

