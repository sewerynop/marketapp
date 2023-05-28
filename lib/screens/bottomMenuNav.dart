import 'package:flutter/material.dart';
import 'package:ride_to_go/main.dart';
import 'package:ride_to_go/screens/addAdverti.dart';
import 'package:ride_to_go/screens/home.dart';

class BottomMenuNav extends StatefulWidget {
  const BottomMenuNav({super.key});

  @override
  State<BottomMenuNav> createState() => _BottomMenuNavState();
}

class _BottomMenuNavState extends State<BottomMenuNav>
    with AutomaticKeepAliveClientMixin<BottomMenuNav> {
  var _selectetPageIndex;

  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectetPageIndex = 0;
    _pages = [
      HomePage(),
      Center(child: Text("Szukaj")),
      AddAdventi(),
      Center(child: Text("Konto")),
    ];
    _pageController = PageController(initialPage: _selectetPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // final tabsMenuBottom = [
  //   MyApp(),
  //   Center(child: Text("Szukaj")),
  //   AddAdventi(),
  //   Center(child: Text("Konto"))
  // ];

  // final List<Map<String, dynamic>> _pages = [
  //   {
  //     'page': HomePage(),
  //   },
  //   {
  //     'page': Center(child: Text("Szukaj")),
  //   },
  //   {
  //     'page': AddAdventi(),
  //   },
  //   {
  //     'page': Center(child: Text("Konto")),
  //   },
  // ];
  // int _selctedPageIndex = 0;
  // void _selctedPage(int index) {
  //   setState(() {
  //     _selctedPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectetPageIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Start',
          ),
          BottomNavigationBarItem(
            //backgroundColor: const Color(0xFF084A76),
            icon: Icon(Icons.search),
            label: 'Szukaj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Sprzedaj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Konto',
            //backgroundColor: Colors.amber,
          ),
        ],
        onTap: (selectetPageIndex) {
          setState(() {
            //_currentIndex = index;
            _selectetPageIndex = selectetPageIndex;
            _pageController.jumpToPage(selectetPageIndex);
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
