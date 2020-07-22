import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // final String _url = 'https://www.dynamyk.biz/';
  //final String _url = 'http://192.168.0.124:8000';
  final String _url = 'http://nasuha.appifylab.com/';
  final String _url1 = 'http://nasuha.appifylab.com/';
  final String _prevURL = 'http://api.linkpreview.net/?key=6cb58299315d95a7c51d3709d6763671&q=';

  prevURL(apiUrl) async {
    var fullUrl = _prevURL + apiUrl;
    print(fullUrl);
    return await http.get(fullUrl);
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    //print(await _setHeaders());
    print(fullUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: await setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.get(fullUrl, headers: await setHeaders());
  }

  getData1(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(fullUrl, headers: await setHeaders());
  }

  putData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    //print(await _setHeaders());
    return await http.put(fullUrl,
        body: jsonEncode(data), headers: await setHeaders());
  }

  setHeaders() async => {
        "Authorization": 'Bearer ' + await _getToken(),
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '$token';
  }
}
