import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = jsonDecode(response.body);
      return responseJson;
    }
    on SocketException {
      Map map = {
        "noInternet": "No Internet"
      };
      return map;
    }
  }

  @override
  Future postApi(String url, data) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: data);
      responseJson = jsonDecode(response.body);
      return responseJson;
    }
    on SocketException {
      Map map = {
        "noInternet": "No Internet"
      };
      return map;
    }
  }

}