import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiExample02 extends StatefulWidget {
  const ApiExample02({super.key});

  @override
  State<ApiExample02> createState() => _ApiExample02State();
}

class _ApiExample02State extends State<ApiExample02> {
  List<Photos> photoslist = [];
  Future<List<Photos>> getPhotos() async {
    final response =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photoslist.add(photos);
      }
      print(photoslist.length);
      return photoslist;
    } else {
      print(photoslist.length);
      return photoslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getPhotos(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: Text('Loding..'));
        } else {
          return ListView.builder(
            itemCount: photoslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(photoslist[index].url.toString()),
                ),
                title: Text('Note id:' + photoslist[index].id.toString()),
                subtitle: Text(photoslist[index].title.toString()),
              );
            },
          );
        }
      },
    ));
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
