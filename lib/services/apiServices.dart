import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ride_to_go/screens/home.dart';

var linkAdress = "https://rideto.azurewebsites.net";

// Pobieranie z API listy wszystkich ogłoszeń na główna stronę
class ApiServices {
  Future getAllPosts() async {
    try {
      final allProductUrl = Uri.parse("$linkAdress/ads");
      final response = await http.get(allProductUrl);
      print(response.statusCode);
      //try {
      return json.decode(response.body);
    } catch (e) {
      print("$e Brak połaczenia z internetem");
    }
  }

// Pobieranie pjedyńczego ogłoszenia
  Future getSingleProduct(int id) async {
    final SingleProductUrl = Uri.parse("$linkAdress/adDetails?id=$id");
    final response = await http.get(SingleProductUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // API POST dodanie ogłoszenia
  Future<Announcement> createAnnouncement(
    //dynamic accountId, // Wstawiać 3, przypisana do konta Seweryn
    // String numberr, // dodaje się automatycznie
    String decription,
    dynamic categoryId,
    dynamic conditionId,
    dynamic frameId,
    String producentId,
    dynamic modelId,
    dynamic price,
    Future push,
    //dynamic statusId, // dodaje się automatycznie
  ) async {
    final response = await http.post(
      Uri.parse('$linkAdress/ads'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        //"accountId": accountId = 3,
        "decription": decription,
        "categoryId": categoryId,
        "conditionId": conditionId,
        "frameId": frameId,
        "producentId": producentId,
        "modelId": modelId,
        "price": price,
        //"statusId": statusId = 1
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Announcement.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Błąd dodania ogłoszenia.'); // faild
    }
  }
}

class Announcement {
  final dynamic accountId;
  //final String numberr;
  final String decription;
  final dynamic categoryId;
  final dynamic conditionId;
  final dynamic frameId;
  final dynamic producentId;
  final dynamic modelId;
  final dynamic price;
  //final dynamic statusId;

  const Announcement({
    required this.accountId,
    //required this.numberr,
    required this.decription,
    required this.categoryId,
    required this.conditionId,
    required this.frameId,
    required this.producentId,
    required this.modelId,
    required this.price,
    //required this.statusId
  });
  //required this.accountId

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      accountId: json['id'],
      //numberr: json['number'],
      decription: json['decription'],
      categoryId: json['categoryId'],
      conditionId: json['conditionId'],
      frameId: json['frameId'],
      producentId: json['producentId'],
      modelId: json['modelId'],
      price: json['price'],
      //statusId: json['statusId']
    );
  }
}

// Usunięcie ogłoszenia:

// Future<Announcement> fetchAlbum() async {
//   final response = await http.get(
//     Uri.parse("https://ridetoapi.azurewebsites.net/adDetails?id="),
//   );
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response, then parse the JSON.
//     return Announcement.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response, then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

Future<DeleteAnnouncement> deleteAnnouncement(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return DeleteAnnouncement.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

// Future<DeleteAnnouncement> deleteAnnouncement(String id) async {
//   final http.Response response = await http.delete(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
// }

class DeleteAnnouncement {
  final int? id;

  const DeleteAnnouncement({this.id});

  factory DeleteAnnouncement.fromJson(Map<String, dynamic> json) {
    return DeleteAnnouncement(
      id: json['accountId'],
      //title: json['title'],
    );
  }
}

// class DeleteAnnouncement {
//   final dynamic accountId;
//   final String numberr;
//   final String decription;
//   final dynamic categoryId;
//   final dynamic conditionId;
//   final dynamic frameId;
//   final dynamic producentId;
//   final dynamic modelId;
//   final dynamic price;
//   final dynamic statusId;

//   const DeleteAlbum({this.id, this.title})

//     factory Announcement.fromJson(Map<String, dynamic> json) {
//     return Announcement(
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
//     );
//   }
// }

// Pobieranie słowników przy dodawaniu ogłoszenia

class ApiSlowniki {
  Future getAllPosts() async {
    final allProductUrl =
        Uri.parse("$linkAdress/dictionary?dictionary=Category");
    final response = await http.get(allProductUrl);
    print(response.statusCode);
    print(response.body);
    try {
      return json.decode(response.body);
    } catch (e) {
      print("$e Brak połaczenia z internetem");
    }
  }
}
