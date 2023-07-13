import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apiWithOutModel extends StatefulWidget {
  const apiWithOutModel({super.key});

  @override
  State<apiWithOutModel> createState() => _apiWithOutModelState();
}

class _apiWithOutModelState extends State<apiWithOutModel> {
  var data;
  Future<void> getuser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(
          response.body.toString()); //decode json in globle var(catch all data)
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Api call'))),
      body: FutureBuilder(
        future: getuser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ReuseableRow(
                          title: 'id', value: data[index]['id'].toString()),
                      ReuseableRow(
                          title: 'name', value: data[index]['name'].toString()),
                      ReuseableRow(
                          title: 'email',
                          value: data[index]['email'].toString()),
                      ReuseableRow(
                          title: 'address',
                          value: data[index]['address']['city'].toString()),
                      ReuseableRow(
                          title: 'company',
                          value: data[index]['company']['name'].toString()),
                      ReuseableRow(
                          title: 'geo',
                          value: data[index]['address']['geo'].toString()),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
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
