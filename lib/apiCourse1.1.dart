import 'dart:convert';

import 'package:ecommerce/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postApi extends StatefulWidget {
  const postApi({super.key});

  @override
  State<postApi> createState() => _postApiState();
}

class _postApiState extends State<postApi> {
  List<PostsModel> postList = []; // create list because api array has no name
  Future<List<PostsModel>> getpostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data = jsonDecode(response.body.toString()); // decode json data
    if (response.statusCode == 200) {
      //200 code mean valid api
      postList.clear(); // if hot reload page will not reload
      for (var i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      print(postList.length);
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getpostApi(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('loading');
        } else {
          return ListView.builder(
            itemCount:
                postList.length, // length of list or(snapshot.data!.length)
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id :${postList[index].id.toString()}'),
                      Text('Title :${postList[index].title.toString()}'),
                      Text('Body :${postList[index].body.toString()}')
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    ));
  }
}
