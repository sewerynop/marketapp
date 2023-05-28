import 'package:ride_to_go/services/apiServices.dart';
import 'package:flutter/material.dart';
//import 'package:ride_to_go/services/deleteAdventi.dart';

import 'deleteAdventi.dart';

class ProductDetail extends StatelessWidget {
  final int id;
  const ProductDetail(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteAdventi(),
                  ));
            },
            icon: const Icon(Icons.delete),
            color: Colors.black,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
      ),
      body: FutureBuilder(
          future: ApiServices().getSingleProduct(id),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ElevatedButton(
                    //     onPressed: () {
                    //       () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => DeleteAdventi(),
                    //             ));
                    //       };
                    //     },
                    //     child: Icon(Icons.delete)),
                    Image.network(
                        "http://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQwAiTymy_OyZBEwIJFa_246RvYGOF0O90qihPNI6CIxUHg3JBkzNeucO7OxlhPyn41ObctlLts5XSFX3lk8Yk"),

                    const SizedBox(height: 30),
                    // Image.network(
                    //   snapshot.data[
                    //       "http://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQwAiTymy_OyZBEwIJFa_246RvYGOF0O90qihPNI6CIxUHg3JBkzNeucO7OxlhPyn41ObctlLts5XSFX3lk8Yk"],
                    //   height: 200,
                    //   width: double.infinity,
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                            "Description: ${snapshot.data['decription']}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Number: ${snapshot.data['number']}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Category: ${snapshot.data['category']['symbol'].toString()}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Condition: ${snapshot.data['condition']['symbol'].toString()}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Frame: ${snapshot.data['frame']['size']}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart_outlined),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

///-----------
// import 'package:flutter/material.dart';
// import 'package:ride_to_go/services/apiServices.dart';

// class ProductDetail extends StatefulWidget {
//   final int id;
//   const ProductDetail(this.id, {super.key});

//   @override
//   State<ProductDetail> createState() {
//     return _ProductDetailState();
//   }
// }

// class _ProductDetailState extends State<ProductDetail> {
//   late Future<ProductDetail> _futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = _futureAlbum;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.redAccent,
//       ),
//       body: FutureBuilder(
//           future: ApiServices().getSingleProduct(id),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return Container(
//                 margin: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _futureAlbum =
//                                 DeleteAnnouncement(snapshot.data!.id.toString())
//                                     as Future<ProductDetail>;
//                           });
//                         },
//                         child: Icon(
//                           Icons.delete,
//                           size: 20,
//                         )),
//                     const SizedBox(height: 30),
//                     //Image.network(
//                     //  snapshot.data['image'],
//                     //  height: 200,
//                     //  width: double.infinity,
//                     //),
//                     const SizedBox(height: 10),
//                     Center(
//                       child: Text("Description: ${snapshot.data['decription']}",
//                           style: const TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.bold)),
//                     ),
//                     const SizedBox(height: 10),
//                     // Text(
//                     //   "Number: ${snapshot.data['number']}",
//                     //   style: const TextStyle(fontSize: 16),
//                     // ),
//                     //Chip(
//                     //   label: Text(
//                     //     snapshot.data['category']['symbol'].toString(),
//                     //     //style:
//                     //     //  const TextStyle(fontSize: 15, color: Colors.white),
//                     //   ),
//                     //   backgroundColor: Colors.blueGrey,
//                     // ),
//                     // Text(
//                     //   snapshot.data['condition'].toString(),
//                     //   style: const TextStyle(fontSize: 15, color: Colors.white),
//                     // ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     //Text(snapshot.data['description']),
//                     Column(
//                       children: [
//                         // Text(
//                         //     "symbol: ${snapshot.data['category']['symbol'].toString()}"),
//                         // Text(
//                         //     "name: ${snapshot.data['category']['name'].toString()}"),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add_shopping_cart_outlined),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//     );
//   }
//}
