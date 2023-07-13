// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/Login'), body: {
        // for login use ..in/api/Login
        'email':
            email, // make sure this email in comas is same as postman body email key as well passward
        'password': password,
      });
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Login sucessfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Login'))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(hintText: 'password'),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .055,
                child: ElevatedButton(
                  onPressed: () {
                    login(
                        emailController.text
                            .toString(), // calling login and provide controllers
                        passwordController.text.toString());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                  ),
                  child: const Text('Log in'),
                ))
          ],
        ),
      ),
    );
  }
}
