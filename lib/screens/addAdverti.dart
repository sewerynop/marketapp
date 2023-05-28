import 'package:flutter/material.dart';
import 'package:ride_to_go/services/apiServices.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:ride_to_go/screens/home.dart';

import 'bottomMenuNav.dart';

class AddAdventi extends StatefulWidget {
  const AddAdventi({super.key});

  @override
  State<AddAdventi> createState() {
    return _AddAdventiState();
  }
}

class _AddAdventiState extends State<AddAdventi>
    with AutomaticKeepAliveClientMixin<AddAdventi> {
  //final TextEditingController _accountId = TextEditingController();
  // //final TextEditingController _numberr = TextEditingController();
  // final TextEditingController _categoryId = TextEditingController();
  // final TextEditingController _conditionId = TextEditingController();
  // final TextEditingController _frameId = TextEditingController();
  // //final TextEditingController _modelId = TextEditingController();
  // final TextEditingController _producentId = TextEditingController();
  final TextEditingController _decription = TextEditingController();
  final TextEditingController _price = TextEditingController();
  //final TextEditingController _statusId = TextEditingController();
  // //var items = <String>["Red", "Green", "Orange", "Blue", "Black"];
  // //String dropdownValue = "Red";

  List categoryItemlist = [];
  Future getCategory() async {
    //var baseUrl = "https://gssskhokhar.com/api/classes/";
    var baseUrl =
        "https://rideto.azurewebsites.net/dictionary?dictionary=Category";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  List conditionItemlist = [];
  Future getCondition() async {
    //var baseUrl = "https://gssskhokhar.com/api/classes/";
    var baseUrl =
        "https://rideto.azurewebsites.net/dictionary?dictionary=Condition";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        conditionItemlist = jsonData;
      });
    }
  }

  List framedItemlist = [];
  Future getFramed() async {
    //var baseUrl = "https://gssskhokhar.com/api/classes/";
    var baseUrl =
        "https://rideto.azurewebsites.net/dictionary?dictionary=Frame";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        framedItemlist = jsonData;
      });
    }
  }

  List producentItemlist = [];
  Future getProducent() async {
    //var baseUrl = "https://gssskhokhar.com/api/classes/";
    var baseUrl =
        "https://rideto.azurewebsites.net/dictionary?dictionary=Producent";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        producentItemlist = jsonData;
      });
    }
  }

  List modelItemlist = [];
  Future getModel() async {
    //var baseUrl = "https://gssskhokhar.com/api/classes/";
    var baseUrl =
        "https://rideto.azurewebsites.net/dictionary?dictionary=Model";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        modelItemlist = jsonData;
      });
    }
  }

  Future<Announcement>? _futureAlbum;

  @override
  void initState() {
    super.initState();
    getCategory();
    getCondition();
    getFramed();
    getProducent();
    getModel();
  }

  var dropdownvalueCategory;
  var dropdownvalueCondition;
  var dropdownvalueFrame;
  var dropdownvalueProducent;

  var _categoryId;
  var _conditionId;
  var _frameId;
  var _producentId;
  var _modelId;
  //var OK;
  //String OK = "Dodano zostało dodane";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dodaj ogłoszenie",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(255, 232, 232, 232),
          centerTitle: true,
        ),
        //bottomNavigationBar: BottomMenuNav(),
        body: Container(
          //child: DropdownButtonExampleState(),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ));
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // TextField(
        //   controller: _accountId,
        //   decoration: const InputDecoration(hintText: 'ID'),
        //   autofocus: true,
        // ),
        // TextField(
        //   controller: _numberr,
        //   decoration: const InputDecoration(hintText: 'numer'),
        //   autofocus: true,
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: TextField(
            controller: _decription,
            decoration: const InputDecoration(hintText: 'Opis'),
            autofocus: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Kategoria'),
            items: categoryItemlist.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['symbol'].toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _categoryId = newVal;
              });
            },
            value: _categoryId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Stan'),
            items: conditionItemlist.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['decription'].toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _conditionId = newVal;
              });
            },
            value: _conditionId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Rama'),
            items: framedItemlist.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['size'].toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _frameId = newVal;
              });
            },
            value: _frameId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Producent'),
            items: producentItemlist.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['symbol'].toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _producentId = newVal;
              });
            },
            value: _producentId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Model'),
            items: modelItemlist.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['name'].toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _modelId = newVal;
              });
            },
            value: _modelId,
          ),
        ),
        // TextField(
        //   controller: _categoryId,
        //   decoration: const InputDecoration(hintText: '_categoryId'),
        //   autofocus: true,
        // ),
        // TextField(
        //   controller: _conditionId,
        //   decoration: const InputDecoration(hintText: '_conditionId'),
        //   autofocus: true,
        // ),
        // TextField(
        //   controller: _frameId,
        //   decoration: const InputDecoration(hintText: '_frameId'),
        //   autofocus: true,
        // ),
        // TextField(
        //   controller: _producentId,
        //   decoration: const InputDecoration(hintText: '_producentId'),
        //   autofocus: true,
        // ),
        // TextField(
        //   controller: _modelId,
        //   decoration: const InputDecoration(hintText: '_modelId'),
        //   autofocus: true,
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: TextField(
            controller: _price,
            decoration: const InputDecoration(hintText: 'Cena'),
            autofocus: true,
          ),
        ),
        // TextField(
        //   controller: _statusId,
        //   decoration: const InputDecoration(hintText: '_statusId'),
        //   autofocus: true,
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _futureAlbum = ApiServices().createAnnouncement(
                    //_accountId.text = '3',
                    ///_numberr.text,
                    ///
                    _decription.text,
                    _categoryId,
                    _conditionId,
                    _frameId,
                    _producentId,
                    _modelId,
                    _price.text,
                    //OK.text = "Ogłoszenie zopstało dodane",
                    //_statusId.text = '1',
                    //dropdownvalueCategory,
                    // dropdownvalueCondition,
                    // dropdownvalueFrame,
                    // dropdownvalueProducent,
                    // dropdownvalueModel,
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage())
                        //ProductDetail(snapshot.data)));
                        ));
              });
            },
            child: const Text('Dodaj ogłoszenie'),
          ),
        ),
      ],
    );
  }

  FutureBuilder<Announcement> buildFutureBuilder() {
    return FutureBuilder<Announcement>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          return Text(snapshot.data!
              .decription); //type 'Null' is not a subtype of type 'String')
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
