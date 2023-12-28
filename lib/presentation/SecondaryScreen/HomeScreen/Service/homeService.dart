// class HomeService{
//
//
//   List<Map<String, dynamic>> sliders = [];
//
//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('${ApiUrls.baseurl}/products/api/sliders/'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       setState(() {
//         sliders = List<Map<String, dynamic>>.from(data);
//       });
//     } else {
//       // Handle error
//       print('Failed to load data');
//     }
//   }
// }
