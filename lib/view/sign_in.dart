import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:http/http.dart' as http;
import 'package:whakaaro/model/login_model.dart';
import 'package:whakaaro/model/progressHud.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  var jsonResponse;
  bool isApiCallProcess = false;

  signIn(String username, String password) async {
    var url = Uri.parse("https://whakaaro.backb.in/api/v1/auth/login/");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = {"username": username, "password": password};

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
        Navigator.pushNamedAndRemoveUntil(
            context, '/HomePage', (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isloading = false;
      });
      print('Response Status : ${res.statusCode}');
      print('Response Body : ${res.body}');
    }
  }

  LoginRequestModel requestModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHud(
      child: builds(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget builds(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (input) => requestModel.username = input,
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
                    onSaved: (input) => requestModel.password = input,
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
                        signIn(
                            usernameController.text, passwordController.text);
                        print(
                            'username ${usernameController.text} || ${passwordController.text}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid Data')),
                        );
                      }
                      // if (validateAndSave()) {
                      //   setState(() {
                      //     isApiCallProcess = true;
                      //   });
                      //
                      //   ApiService apiServices = new ApiService();
                      //   apiServices.login(requestModel).then((value) {
                      //     setState(() {
                      //       isApiCallProcess = false;
                      //     });
                      //     if (value.token.isNotEmpty) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(content: Text('Login Successful')));
                      //       print(value.token);
                      //
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(content: Text(value.error)));
                      //     }
                      //   });
                      //   print(requestModel.toJson());
                      // }
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
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
