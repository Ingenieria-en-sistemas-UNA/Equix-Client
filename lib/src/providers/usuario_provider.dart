import 'dart:convert';

import 'package:equix/src/preferencias_usuario/PreferenciasUsuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  String _baseUrl = "http://192.168.43.102:81";
  final _prefs = new PreferenciasUsuario();

  Future<Map<String,dynamic>> login( String email, String password ) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post( '$_baseUrl/api/users/login', body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if( decodedResp.containsKey('idToken') ){
      _prefs.token = decodedResp['idToken'];
      return { 'okey': true, 'token': decodedResp['idToken'] };
    }
      return { 'okey': false, 'mensaje': decodedResp['error']['message'] };
  }


  Future<Map<String,dynamic>> nuevoUsuario( String email, String password ) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post('$_baseUrl/api/users/signup',body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    // print(decodedResp);

    if( decodedResp.containsKey('idToken') ){
      _prefs.token = decodedResp['idToken'];
      return { 'okey': true, 'token': decodedResp['idToken'] };
    }
      return { 'okey': false, 'mensaje': decodedResp['error']['message'] };

  }

}