import 'dart:convert';
import 'dart:io';
import 'package:flutter_api_with_bloc/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'custom_exception.dart';

class ApiProvider {

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var response = await http.get(Uri.parse(baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      printLog(url);

      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException("No Internet Connection!");
    }
    return responseJson;
  }


  Future<dynamic> post(String url, var body) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body),
      );

      responseJson = _response(response);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  dynamic _response(http.Response response) {

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 201:
      case 204:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        return responseJson;
      case 302:
      case 401:
        throw UnauthorisedException("Something went wrong");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 412:
        var responseJson = json.decode(response.body.toString());
        return UnauthorisedException(responseJson);

      case 500:
        var responseJson = json.decode(response.body.toString());
        var error = responseJson["errors"] ?? "";

        throw BadRequestException(response.body.toString());
      case 422:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}