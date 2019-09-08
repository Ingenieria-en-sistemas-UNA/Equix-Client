import 'dart:convert';

import 'package:equix/src/models/author_model.dart';
import 'package:equix/src/preferencias_usuario/PreferenciasUsuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  String _baseUrl = "http://192.168.43.102:81";
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'author': {'name': 'name'}
    };
    try {
      final resp = await http.post('$_baseUrl/api/users/login',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      print(decodedResp);

      if (decodedResp['ok'] == true) {
        Map<String, dynamic> data = decodedResp['data'];
        _prefs.token = data['token'];
        var author = new Author.fromJson(data['author']);
        _prefs.author = author;
        return {'okey': true, 'token': data['token'], 'author': author};
      }
      throw 'error';
    } catch (e) {
      return {'okey': false, 'mensaje': 'error'};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password, String name) async {
    final authData = {
      'email': email,
      'password': password,
      'author': {"name": name}
    };

    try {
      final resp = await http.post('$_baseUrl/api/users/signup',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      // print(decodedResp);

      if (decodedResp['ok'] == true) {
        Map<String, dynamic> data = decodedResp['data'];
        _prefs.token = data['token'];
        var author = new Author.fromJson(data['author']);
        _prefs.author = author;
        return {'okey': true, 'token': data['token'], 'author': author};
      }
      throw 'error';
    } catch (e) {
      return {'okey': false, 'mensaje': 'error'};
    }

  }
}
