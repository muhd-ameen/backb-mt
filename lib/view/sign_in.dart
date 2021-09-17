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
  var jsonResponse;

  signIn(String username, String password) async {
    print(
      'username: $username || password: $password',
    );
    var url = Uri.parse(
      "https://whakaaro.backb.in/api/v1/auth/login/",
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = {"username": "$username", "password": "$password"};
    var response = await http.post(url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');
      if (jsonResponse != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Successful')));
        sharedPreferences.setString('token', jsonResponse['token']);
        isLogged();
        Navigator.pushNamedAndRemoveUntil(
            context, '/HomePage', (Route<dynamic> route) => false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')));
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');
    }
    return response;
  }

  isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
  }

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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color(0xFF0065FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 130),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        signIn(
                            usernameController.text, passwordController.text);
                      }
                    },
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
