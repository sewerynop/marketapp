import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ride_to_go/services/apiServices.dart';
import 'package:ride_to_go/screens/product_detail.dart';
import 'package:ride_to_go/screens/addAdverti.dart';
import '../plugins/carousel.dart';
//import 'package:ride_to_go/screens/bottomMenuNav.dart';
//import 'package:flutter/cupertino.dart';

// Lista przykładowych foto do slidera
// final List<String> imgList = [
//   'https://images.pexels.com/photos/5464921/pexels-photo-5464921.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//   'https://images.pexels.com/photos/100582/pexels-photo-100582.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//   'https://images.pexels.com/photos/276517/pexels-photo-276517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  var _selectetPageIndex;

  late List<Widget> pages;
  late PageController _pageController;

  // Odswiezanie home
  Future refresh() async {
    setState(() {
      ApiServices().getAllPosts();
    });
  }
  // koniec Odswiezanie home

// sprawdzanie połaczenia z internetem
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    _selectetPageIndex = 0;
    pages = [
      HomePage(),
      Center(child: Text("Szukaj")),
      AddAdventi(),
      Center(child: Text("Konto")),
    ];
    _pageController = PageController(initialPage: _selectetPageIndex);
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() {
              isAlertSet = true;
            });
          }
        },
      );

  Future<void> showDialogBox() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Brak połączenia z internetem"),
          content: const Text(
              "Sprawdz połączenie z internetem i otwórz aplikacje ponownie"),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
    _pageController.dispose();
  }

// koniec sprawdzanie połaczenia z internetem

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      //CarouselWithDotPage(imgList: imgList),
      appBar: AppBar(
        //title: const Text("RideToGo"),
        centerTitle: true,
        elevation: 1, // wielkość cienia pod AppBarem
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        shadowColor: Color.fromARGB(255, 212, 212, 212),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAdventi(),
                  ));
            },
            icon: const Icon(Icons.add),
            color: Colors.black,
          ),
        ],
      ),

      // RefreshIndicator to odswiezenie home pull down
      /*
      PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),*/
      body: //PageViewControll(),
          RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: ApiServices().getAllPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                //CarouselWithDotPage(imgList: imgList),
                SizedBox(height: 5.0),
                Expanded(
                  child: GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      snapshot.data[index]['id'])));
                        },
                        child: Container(
                          color: Color.fromARGB(255, 240, 240, 240),
                          height: 50,
                          child: Column(
                            children: [
                              Center(
                                child: Image.network(
                                    "http://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQwAiTymy_OyZBEwIJFa_246RvYGOF0O90qihPNI6CIxUHg3JBkzNeucO7OxlhPyn41ObctlLts5XSFX3lk8Yk"),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    3.0, 2.0, 0.0, 2.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data[index]['decription'],
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    3.0, 0.0, 0.0, 0.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "${snapshot.data[index]['price']} zł"
                                          .toString(),
                                      textAlign: TextAlign.left),
                                ),
                              ),
                            ],
                          ),

                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               ProductDetail(snapshot.data[index]['id'])));
                          // },
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      mainAxisExtent: 200,
                    ),
                  ),
                ),
              ]);
            }
            //CarouselWithDotPage(imgList: imgList);
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PageViewControll extends StatefulWidget {
  const PageViewControll({super.key});

  @override
  State<PageViewControll> createState() => _PageViewControllState();
}

class _PageViewControllState extends State<PageViewControll> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: PageView(
        controller: controller,
        children: const <Widget>[
          Center(
            child: HomePage(),
          ),
          Center(
            child: AddAdventi(),
          ),
        ],
      ),
    );
  }
}

// Wyszukiwarka funkcje START
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Wyszukiwanie jeszcze nie działa",
    //"Apple",
    //"Banana",
    //"Pear",
    //"Watermelon",
    //"Strawberries",
    //"Raspberries"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

@override
ThemeData appBarTheme(BuildContext context) {
  return Theme.of(context).copyWith(
      //hintColor: Colors.white,
      //hintText: "Piesek",
      );
}
// Wyszukiwarka funkcje START

class Slider extends StatefulWidget {
  const Slider({super.key});

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          "Slider",
          style: TextStyle(fontSize: 20.0, color: Colors.green),
        ),
      ),
    );
  }
}

/* 
Wersja przycisku iOS
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text("Brak połączenia z internetem"),
          content: const Text("Sprawdz połączenie z internetem i otwórz aplikacje ponownie"),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("OK"),
            ),
          ],
        ),
      );
*/

// class BottomMenuNav extends StatefulWidget {
//   const BottomMenuNav({super.key});

//   @override
//   State<BottomMenuNav> createState() => _BottomMenuNavState();
// }

// class _BottomMenuNavState extends State<BottomMenuNav> {
//   final tabsMenuBottom = [
//     HomePage(),
//     Center(child: Text("Szukaj")),
//     AddAdventi(),
//     Center(child: Text("Konto"))
//   ];

//   // final List<Map<String, Object>> _pages = [
//   //   {
//   //     'page': HomePage(),
//   //   },
//   //   {
//   //     'page': Center(child: Text("Szukaj")),
//   //   },
//   //   {
//   //     'page': AddAdventi(),
//   //   },
//   //   {
//   //     'page': Center(child: Text("Konto")),
//   //   },
//   // ];

//   int _selctedPageIndex = 0;
//   void _selctedPage(int index) {
//     setState(() {
//       _selctedPageIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selctedPageIndex]['page'], //tabsMenuBottom[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _selctedPage,
//         currentIndex: _selctedPageIndex,
//         unselectedItemColor: Colors.black,
//         selectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Start',
//           ),
//           BottomNavigationBarItem(
//             //backgroundColor: const Color(0xFF084A76),
//             icon: Icon(Icons.search),
//             label: 'Szukaj',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_box),
//             label: 'Sprzedaj',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Konto',
//             //backgroundColor: Colors.amber,
//           ),
//         ],
//         // onTap: (index) {
//         //   setState(() {
//         //     _currentIndex = index;
//         //   });
//         // },
//       ),
//     );
//   }
// }
