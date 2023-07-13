import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker(); // for image
  bool showspanner = false;

  Future getImage() async {
    //get imgae from gallery
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80); // pick image from also quality
    if (pickedFile != null) {
      image =
          File(pickedFile.path); // save image in variable through pick. path
      setState(() {});
    } else {
      print('image not selected');
    }
  }

  Future<void> uploadImage() async {
    // upload fun
    setState(() {
      showspanner = true;
    });
    var stream = http.ByteStream(image!
        .openRead()); //A stream of chunks of bytes representing a single piece of data.
    stream.cast();
    var length = await image!.length(); // length of image

    var uri =
        Uri.parse('https://fakestoreapi.com/products'); // url where upload

    var request = http.MultipartRequest(
        'POST', uri); // multipartrequest use for senfing image/file to server

    request.fields['title'] = 'static title'; // fields

    var multiport = http.MultipartFile('image', stream,
        length); //A file to be uploaded as part of a MultipartRequest.
    request.files.add(multiport);
    var response = await request.send(); // send to server/api

    if (response.statusCode == 200) {
      // check data is valid or not
      setState(() {
        showspanner = false;
      });
      print('image uploaded');
    } else {
      setState(() {
        showspanner = false;
      });
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      // for wiating progress
      inAsyncCall: showspanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('upload image')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage(); // call get image
              },
              child: Container(
                  child: image == null // if else
                      ? const Center(
                          child: Text('pick image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                uploadImage(); // call upload image
              },
              child: Container(
                width: 100,
                height: 20,
                color: Colors.green,
                child: Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
