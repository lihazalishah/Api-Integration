import 'dart:async';

import 'package:ecommerce/apiLoginSignup/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        // for login use ..in/api/Login
        'email':
            email, // make sure this email in comas is same as postman body email key as well passward
        'password': password,
      });
      if (response.statusCode == 200) {
        print('account created sucessfully');
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
      appBar: AppBar(title: const Center(child: Text('SignUp'))),
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
                    // Timer(Duration(seconds: 4), () {
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => Login(),
                    //       ));
                    // });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));

                    login(
                        emailController.text
                            .toString(), // calling login and provide controllers
                        passwordController.text.toString());
                  },
                  child: const Text('Sign Up'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .055,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  child: const Text('Go for login'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
