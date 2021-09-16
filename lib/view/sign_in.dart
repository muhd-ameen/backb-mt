import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:http/http.dart' as http;
import 'package:whakaaro/view/HomePage.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  var jsonResponse;

  signIn(String email, String password) async {
    var url = Uri.parse("https://whakaaro.backb.in/api/v1/auth/login/");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "username": email,
      "password": password,
    };
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print('Response Status : ${res.statusCode}');
      print('Response Body : ${res.body}');
      if (jsonResponse != null) {
        setState(() {
          _isloading = false;
        });
        sharedPreferences.setString('token', jsonResponse['token']);
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext)), (route) => false)
        Navigator.pushNamed(context, '/HomePage');
      }
    } else {
      setState(() {
        _isloading = false;
      });
      print('Response Status : ${res.statusCode}');

      print('Response Body : ${res.body}');
    }
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'main',
                    child: Image.asset(
                      'assets/images/signin.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
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
                  controller: _phoneController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
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
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isloading = true;
                      });
                      signIn(_phoneController.text, _passwordController.text);
                      print(
                          'username ${_phoneController.text} || ${_passwordController.text}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }else {
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
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
