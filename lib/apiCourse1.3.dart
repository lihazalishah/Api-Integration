import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Users_model.dart';

// ignore: use_key_in_widget_constructors
class UsersApi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersApiState();
}

class _UsersApiState extends State<UsersApi> {
  List<UsersModel> userslist = [];
  Future<List<UsersModel>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // 200 mean vlaid api
      for (var i in data) {
        // UsersModel User = UsersModel(
        //     id: i['id'],
        //     username: i['username'],
        //     address: i['address']['city'],
        //     company: i['company']['name']);
        // userslist.add(User);
        userslist.add(UsersModel.fromJson(i));
      }
      //print(userslist.length);
      return userslist;
    } else {
      return userslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Api call'))),
        body: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: userslist.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ReuseableRow(  // both way is correct getting data either use sanpdhot or direct list
                        //     title: 'ID',
                        //     value: snapshot.data![index].id.toString()),
                        ReuseableRow(
                            title: 'ID', value: userslist[index].id.toString()),
                        ReuseableRow(
                            title: 'Name',
                            value: userslist[index].name.toString()),
                        ReuseableRow(
                            title: 'Email',
                            value: userslist[index].email.toString()),
                        ReuseableRow(
                            title: 'phone Number',
                            value: userslist[index].phone.toString()),
                        ReuseableRow(
                            title: 'City /Street',
                            value:
                                "${userslist[index].address!.city} ${userslist[index].address!.street}"),
                        ReuseableRow(
                            title: 'Company',
                            value: userslist[index].company!.name.toString()),
                      ],
                    ),
                  ));
                },
              );
            }
          },
        ));
  }
}

// ignore: must_be_immutable
class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
