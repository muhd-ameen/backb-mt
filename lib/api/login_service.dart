import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:whakaaro/model/login_model.dart';

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    var url = Uri.parse("https://whakaaro.backb.in/api/v1/auth/login/");

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load data');
    }
  }
}
