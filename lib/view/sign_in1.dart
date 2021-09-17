import 'package:flutter/material.dart';
import 'package:whakaaro/api/login_service.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:whakaaro/model/login_model.dart';
import 'package:whakaaro/model/progressHud.dart';

class SignIn1 extends StatefulWidget {
  const SignIn1({Key key}) : super(key: key);

  @override
  _SignIn1State createState() => _SignIn1State();
}

class _SignIn1State extends State<SignIn1> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var jsonResponse;
  bool isApiCallProcess = false;

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

                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        ApiService apiServices = new ApiService();
                        apiServices.login(requestModel).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if (value.token.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login Successful')));
                            print(value.token);

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value.error)));
                          }
                        });
                        print(requestModel.toJson());
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
