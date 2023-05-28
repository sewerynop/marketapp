import 'package:flutter/material.dart';
import 'package:ride_to_go/services/apiServices.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DeleteAdventi extends StatefulWidget {
  const DeleteAdventi({super.key});

  @override
  State<DeleteAdventi> createState() {
    return _DeleteAdventiState();
  }
}

class _DeleteAdventiState extends State<DeleteAdventi> {
  late Future<DeleteAnnouncement> _futureAlbum;

  Future<Announcement> fetchAlbum() async {
    final response = await http.get(
      Uri.parse("https://ridetoapi.azurewebsites.net/adDetails?id="),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return Announcement.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    //_futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<DeleteAnnouncement>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            // If the connection is done,
            // check for response data or an error.
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data?.id.toString() ?? 'Deleted'),
                    ElevatedButton(
                      child: const Text('Delete Data'),
                      onPressed: () {
                        setState(() {
                          _futureAlbum =
                              deleteAnnouncement(snapshot.data!.id.toString());
                        });
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
