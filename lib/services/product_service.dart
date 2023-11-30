import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService{
  final _baseUrl = 'http://plain-marbled-muskox.glitch.me/shoes';

  Future<List>getAll() async{
    http.Response response = await http.get(Uri.parse(_baseUrl));
    if(response.statusCode == HttpStatus.ok){
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    }else{
      return [];
    }
  }

  //getbyname
  Future<List>getByName(String name) async{
    final String url = '$_baseUrl?name_like=$name';
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == HttpStatus.ok){
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    }else{
      return [];
    }
  }

  //getbyid
  Future<ProductsInfo>getById(int id) async{
    final String url = '$_baseUrl/$id';
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      return ProductsInfo.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load data!');
    }
  }
}