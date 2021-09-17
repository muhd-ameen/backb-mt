import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whakaaro/constants/api_assets.dart';
import 'package:whakaaro/model/homePage_model.dart';
import 'package:whakaaro/view/HomePage.dart';

double lat;
double long;

class ApiManager {
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
        print(response.body);
        print(response.statusCode);
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
}
