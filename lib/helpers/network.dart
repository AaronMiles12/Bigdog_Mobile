import 'dart:convert';

import 'package:big_dog_app/helpers/loader-snack.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../features/onboarding/viewmodel/authviewmodel.dart';

class ApiProvider {
  final String _baseURL = "https://bigdog.thecloudlearner.com/";
  final controller = Get.put(AuthViewModel());

  get(String url) async {
    try {
      final response = await http.get(Uri.parse(_baseURL + url));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      }
    } catch (e) {
      rethrow;
    }
  }

  post(String url, Map<String, dynamic> data) async {
    print(controller.userAuthToken);
    try {
      String jsondata = json.encode(data);
      final response =
          await http.post(Uri.parse(_baseURL + url), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': controller.userAuthToken,
        'refreshToken': controller.userRefreshToken
      });
      print(response.body);
      print(response.statusCode);

      var responseJson = json.decode(response.body.toString());

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 400) {
        return responseJson;
      }
      if (response.statusCode == 500) {
        LoaderService().showSnackbar("Error", "Something went wrong");
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }

  put(String url, Map<String, dynamic> data) async {
    try {
      String jsondata = json.encode(data);
      final response =
          await http.put(Uri.parse(_baseURL + url), body: jsondata, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }

  delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(_baseURL + url));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //bad practice to print error use logger
      // print(e);
      rethrow;
    }
  }
}
