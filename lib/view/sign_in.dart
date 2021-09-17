import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  var jsonResponse;

  signIn(String username, String password) async {
    print(
      'username: $username || password: $password',
    );
    var url = Uri.parse(
      "https://whakaaro.backb.in/api/v1/auth/login/",
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = {
      "username":"$username",
      "password":"$password"
    };
    var response = await http.post(
        url,
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8")
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isloading = false;
        });
        sharedPreferences.setString('token', jsonResponse['token']);
        Navigator.pushNamedAndRemoveUntil(
            context, '/HomePage', (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isloading = false;
      });
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');
    }
    return response;
  }

  // Future<void> login() async {
  //   if (passwordController.text.isNotEmpty &&
  //       usernameController.text.isNotEmpty) {
  //     var response = await http.post(
  //         Uri.parse("https://whakaaro.backb.in/api/v1/auth/login/"),
  //         body: ({
  //           'username': usernameController.text,
  //           'password': passwordController.text
  //         }));
  //     if (response.statusCode == 300) {
  //       jsonResponse = json.decode(response.body);
  //
  //       print('Response Status : ${response.statusCode}');
  //       print('Response Body : ${response.body}');
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('invalid credential')));
  //
  //       print('Response Status : ${response.statusCode}');
  //       print('Response Body : ${response.body}');
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('fields are blank')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'main',
                    child: Image.asset(
                      'assets/images/food.jpg',
                      height: 300,
                      width: 300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.left,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Phone Number',
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.left,
                    // obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Password',
                      prefixIcon: Icon(Icons.password),
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 130),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _isloading = true;
                        });
                        // login();
                        signIn(
                            usernameController.text, passwordController.text);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid Data')),
                        );
                      }
                    },
                    color: Color(0xFF0065FF),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
