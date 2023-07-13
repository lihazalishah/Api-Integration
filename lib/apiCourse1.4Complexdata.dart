import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/products_model.dart';

// ignore: camel_case_types
class productsApi extends StatefulWidget {
  const productsApi({super.key});

  @override
  State<productsApi> createState() => _productsApiState();
}

class _productsApiState extends State<productsApi> {
  Future<ProductsModel> getProduct() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/3fb0fe79-c4dd-4155-bd9c-926df8dbd37f'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('complex api'))),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<ProductsModel>(
                  future: getProduct(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        //scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot
                                      .data!.data![index].shop!.name
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data!.data![index].shop!.shopemail
                                      .toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.data![index].shop!.image
                                        .toString()),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * .5,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data![index].images!.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .data![index]
                                                      .images![position]
                                                      .url
                                                      .toString()))),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Icon(snapshot.data!.data![index].inWishlist! ==
                                        true
                                    ? Icons.favorite
                                    : Icons.face_2_outlined),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
