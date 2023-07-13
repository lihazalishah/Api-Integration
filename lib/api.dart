import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Api extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getUsers() async {
    var usersList = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jasonData = jsonDecode(response.body); // decode date in jason formate
    // print(jasonData); // print data on button call

    for (var i in jasonData) {
      // i=0 for 1st time and then inc by 1 next time repeate till end
      userModel user = userModel(i['name'], i['email'],
          i['company']['name']); // pass name , username same write on api
      usersList.add(user); // user in list eveery time
    }
    //print(usersList); // print all user
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      // data from api future
      future: getUsers(), // defined function
      builder: (context, AsyncSnapshot snapshot) {
        /**Immutable representation of the most recent interaction with an asynchronous computation.
               See also:
              StreamBuilder, which builds itself based on a snapshot from interacting with a Stream.
              FutureBuilder, which builds itself based on a snapshot from interacting with a Future. */
        if (snapshot.data == null) {
          return Container(
            child: Text('Noting in api'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length, // length of data
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(snapshot.data[i].name),
                subtitle: Text(snapshot.data[i].company),
              );
            },
          );
        }
      },
    ));
  }
}

class userModel {
  // for geeting data we cretae class
  var name;
  var company;
  var email;

  userModel(
    this.name,
    this.email,
    this.company,
  );
}
