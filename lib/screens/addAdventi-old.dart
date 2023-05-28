// import 'package:flutter/material.dart';
// import 'package:ride_to_go/services/apiServices.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class AddAdventi extends StatefulWidget {
//   const AddAdventi({super.key});

//   @override
//   State<AddAdventi> createState() {
//     return _AddAdventiState();
//   }
// }

// class _AddAdventiState extends State<AddAdventi> {
//   final TextEditingController _accountId = TextEditingController();
//   //final TextEditingController _numberr = TextEditingController();
//   final TextEditingController _categoryId = TextEditingController();
//   final TextEditingController _conditionId = TextEditingController();
//   final TextEditingController _frameId = TextEditingController();
//   final TextEditingController _modelId = TextEditingController();
//   final TextEditingController _producentId = TextEditingController();
//   final TextEditingController _decription = TextEditingController();
//   final TextEditingController _price = TextEditingController();
//   final TextEditingController _statusId = TextEditingController();
//   var items = <String>["Red", "Green", "Orange", "Blue", "Black"];
//   String dropdownValue = "Red";

//   List categoryItemlist = [];
//   Future getAllCategory() async {
//     //var baseUrl = "https://gssskhokhar.com/api/classes/";
//     var baseUrl =
//         "https://rideto.azurewebsites.net/dictionary?dictionary=Category";

//     http.Response response = await http.get(Uri.parse(baseUrl));

//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         categoryItemlist = jsonData;
//       });
//     }
//   }

//   /*
//       accountId: json['id'],
//       numberr: json['number'],
//       decription: json['decription'],
//       categoryId: json['categoryId'],
//       conditionId: json['conditionId'],
//       frameId: json['frameId'],
//       producentId: json['producentId'],
//       modelId: json['modelId'],
//       price: json['price'],
//       statusId: json['statusId'],
//   */

//   Future<Announcement>? _futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     getAllCategory();
//   }

//   var dropdownvalue;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Dodaj ogłoszenie",
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Color.fromARGB(255, 232, 232, 232),
//           centerTitle: true,
//         ),
//         body: Container(
//           //child: DropdownButtonExampleState(),
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
//         ));
//   }
// //}

// // class DropdownButtonExampleState extends StatefulWidget {
// //   const DropdownButtonExampleState({super.key});

// //   @override
// //   State<DropdownButtonExampleState> createState() =>
// //       _DropdownButtonExampleStateState();
// // }

// // class _DropdownButtonExampleStateState
// //     extends State<DropdownButtonExampleState> {
// //   List<String> list = <String>["Red", "Green", "Orange", "Blue", "Black"];
// //   String dropdownValue = "Red";

// //   @override
// //   Widget build(BuildContext context) {
// //     return DropdownButton(
// //       value: dropdownValue,
// //       icon: Icon(Icons.arrow_downward),
// //       elevation: 16,
// //       style: const TextStyle(color: Colors.deepPurple),
// //       underline: Container(
// //         height: 2,
// //         color: Colors.deepPurpleAccent,
// //       ),
// //       onChanged: (String? value) {
// //         // This is called when the user selects an item.
// //         setState(() {
// //           dropdownValue = value!;
// //         });
// //       },
// //       items: list.map<DropdownMenuItem<String>>((String value) {
// //         return DropdownMenuItem<String>(
// //           value: value,
// //           child: Text(value),
// //         );
// //       }).toList(),
// //     ); // onChanged: onChanged)
// //   }
// // }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         // TextField(
//         //   controller: _accountId,
//         //   decoration: const InputDecoration(hintText: 'ID'),
//         //   autofocus: true,
//         // ),
//         // TextField(
//         //   controller: _numberr,
//         //   decoration: const InputDecoration(hintText: 'numer'),
//         //   autofocus: true,
//         // ),
//         DropdownButton(
//           hint: Text('Kategoria'),
//           items: categoryItemlist.map((item) {
//             return DropdownMenuItem(
//               value: item['id'].toString(),
//               child: Text(item['symbol'].toString()),
//             );
//           }).toList(),
//           onChanged: (newVal) {
//             setState(() {
//               dropdownvalue = newVal;
//             });
//           },
//           value: dropdownvalue,
//         ),
//         TextField(
//           controller: _decription,
//           decoration: const InputDecoration(hintText: 'opis'),
//           autofocus: true,
//         ),
//         TextField(
//           controller: _categoryId,
//           decoration: const InputDecoration(hintText: '_categoryId'),
//           autofocus: true,
//         ),
//         TextField(
//           controller: _conditionId,
//           decoration: const InputDecoration(hintText: '_conditionId'),
//           autofocus: true,
//         ),
//         TextField(
//           controller: _frameId,
//           decoration: const InputDecoration(hintText: '_frameId'),
//           autofocus: true,
//         ),
//         TextField(
//           controller: _producentId,
//           decoration: const InputDecoration(hintText: '_producentId'),
//           autofocus: true,
//         ),
//         TextField(
//           controller: _modelId,
//           decoration: const InputDecoration(hintText: '_modelId'),
//           autofocus: true,
//         ),
//         TextField(
//           controller: _price,
//           decoration: const InputDecoration(hintText: '_price'),
//           autofocus: true,
//         ),
//         // TextField(
//         //   controller: _statusId,
//         //   decoration: const InputDecoration(hintText: '_statusId'),
//         //   autofocus: true,
//         // ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureAlbum = ApiServices().createAnnouncement(
//                 _accountId.text,
//                 //_numberr.text,
//                 _decription.text,
//                 _categoryId.text,
//                 _conditionId.text,
//                 _frameId.text,
//                 _producentId.text,
//                 _modelId.text,
//                 _price.text,
//                 //_statusId.text = '1',
//               );
//             });
//           },
//           child: const Text('Dodaj ogłoszenie'),
//         ),
//       ],
//     );
//   }

//   FutureBuilder<Announcement> buildFutureBuilder() {
//     return FutureBuilder<Announcement>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!
//               .categoryId); //type 'Null' is not a subtype of type 'String')
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
