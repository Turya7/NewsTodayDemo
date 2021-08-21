import 'dart:io';
import 'package:http/http.dart' as http;

class ApiCall {

  Future<dynamic> get(String url) async {
    print("--url-->" + url);
    var responseJson;
    final response = await http.get(Uri.parse(url)).timeout(Duration(seconds:  90));
    responseJson = response;
    return responseJson;
  }

}