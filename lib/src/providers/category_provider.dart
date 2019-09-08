import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' as foundation;

import 'package:equix/src/models/category_model.dart';

class CategoryProvider {
  
  CategoryProvider();

  

  String _baseUrl = "http://192.168.43.102:81";

  List<Category> _categories = new List();

  bool _loading = false;

  Future<List<Category>> _processResponse(url) async {
    try {
      final reponse = await http.get(url);
      final decodedData = json.decode(reponse.body);
      final categories = new Categories.fromJsonList(decodedData);
      return categories.items;  
    } catch (e) {
    }
    return [];
  }

  Future<List<Category>> getCategories() async {
    if (_loading) return [];
    _loading = true;
    final response = await _processResponse('$_baseUrl/api/categories');
    _loading = false;
    return response;
  }

  List<Category> updatePhrases(List<Category> phrasesResponse) {
    return foundation.listEquals<Category>(_categories, phrasesResponse)
        ? _categories
        : phrasesResponse;
  }

}
