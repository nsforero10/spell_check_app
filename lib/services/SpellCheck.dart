import 'dart:async';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

enum Methods { GET, POST, PUT, PATCH, DELETE }

class SpellCheckService {
  SpellCheckService(this.method, {this.path, this.body});
  Map<String, Object> body;
  Methods method;
  String path;
  String apiHost =  'http://localhost:3000';

  Future<String> doRequest() async {
    http.Response response;
    Future<http.Response> request;

    switch (method) {
      
      case Methods.GET:{
        request = http.get(
          apiHost + path,
          // body: json.encode(body)
          headers: {'Content-type': 'application/json'} 
        );
      }
      break;
      case Methods.POST:
        request = http.post(
          apiHost + path,
          body: json.encode(body),
          headers: {'Content-type': 'application/json'} 
        );
        break;
      case Methods.PUT:
        request = http.put(
          apiHost + path,
          body: json.encode(body),
          headers: {'Content-type': 'application/json'} 
        );
        break;
      case Methods.PATCH:
        request = http.patch(
          apiHost + path,
          body: json.encode(body),
          headers: {'Content-type': 'application/json'} 
        );
        break;
      case Methods.DELETE:
        request = http.delete(
          apiHost + path,
        );
        break;
    }
    try {
      response = await request.timeout(Duration(seconds: 40));
    }
    catch(e){
      print(e);
    }
    return response.body;

  }
}
