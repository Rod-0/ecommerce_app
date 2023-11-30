import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserService{
  final String _baseUrl = 'http://plain-marbled-muskox.glitch.me/users?';

  //login
  Future<bool>aunthenticate(String username,String password) async{
    final String url = '${_baseUrl}username=$username&password=$password';
    http.Response response= await http.get(Uri.parse(url));
    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = response.body;
      final users = json.decode(jsonResponse);
      return users.isNotEmpty;
    }else{
      throw Exception('Failed to load data!');
    }
  }

 
  
}