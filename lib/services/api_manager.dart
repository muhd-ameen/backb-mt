import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whakaaro/constants/api_assets.dart';
import 'package:whakaaro/model/homePage_model.dart';
import 'package:whakaaro/view/HomePage.dart';


class ApiManager {


  double lat;
  double long;
  var jsonResponse;
  var homeModel;

  Future<HomeModel> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(Strings.getUrl),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.toString()}',
        },
      );
      if (response.statusCode == 200) {
        print('Status code : ${response.statusCode}');
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        homeModel = HomeModel.fromJson(jsonMap);
        long = jsonMap["data"]["branch"]["location"]["coordinates"][0];
        lat = jsonMap["data"]["branch"]["location"]["coordinates"][1];
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (Exception) {
      return homeModel;
    }
    return homeModel;
  }



  isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
  }

  signIn(String username, String password, BuildContext context) async {
    print(
      'username: $username || password: $password',
    );
    var url = Uri.parse(
      Strings.postUrl,
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
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Credential')));
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');
    }
    return response;
  }
}
