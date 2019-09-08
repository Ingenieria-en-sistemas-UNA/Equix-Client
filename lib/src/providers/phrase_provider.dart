import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

import 'package:equix/src/models/phrase_model.dart';
import 'package:signalr_client/signalr_client.dart';

class PhraseProvider {
  
  PhraseProvider(){
    openConnection();
  }

  HubConnection _hubConnection;
  
  bool _connectionIsOpen = false;

  String _baseUrl = "http://192.168.43.102:81";

  List<Phrase> _phrases = new List();

  bool _loading = false;

  final _phrasesStreamController = StreamController<List<Phrase>>.broadcast();

  Function(List<Phrase>) get phrasesSink => _phrasesStreamController.sink.add;

  Stream<List<Phrase>> get phrasesStream => _phrasesStreamController.stream;

  void dispose() {
    _phrasesStreamController?.close();
  }

  Future<List<Phrase>> _processResponse(url) async {
    try {
      final reponse = await http.get(url);
      final decodedData = json.decode(reponse.body);
      final phrases = new Phrases.fromJsonList(decodedData);
      return phrases.items;  
    } catch (e) {
      return null;
    }
  }


  Future<String> createPhrase(Phrase phrase) async {
    try {
      var jsonPhrase = phraseToJson(phrase);
      final response = await http.post('$_baseUrl/api/phrases', body: jsonPhrase, headers: {
        'Content-Type' : 'application/json'
      });
      if(response.statusCode >= 200 && response.statusCode < 300){
        var phraseDedoced = phraseFromJson(response.body);
        _phrases.add(phraseDedoced);
        phrasesSink(_phrases);
        await this.sendBySock(phraseDedoced);
        return 'Exitoso';
      }  
      return 'Error';
    } catch (e) {
      return e.toString();
    }
  }


  Future<List<Phrase>> getPhrases() async {
    if (_loading) return [];
    _loading = true;

    final response = await _processResponse('$_baseUrl/api/phrases');
    if(response != null){
      _phrases = updatePhrases(response);
      phrasesSink(_phrases);
    }
    _loading = false;
    return response;
  }

  Future<void> sendBySock(Phrase phrase) async {
    await openConnection();
    _hubConnection.invoke("SendPhrase", args: <Object>[phrase]);
  }

  List<Phrase> updatePhrases(List<Phrase> phrasesResponse) {
    return foundation.listEquals<Phrase>(_phrases, phrasesResponse)
        ? _phrases
        : phrasesResponse;
  }

  Future<void> openConnection() async {
    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder().withUrl('$_baseUrl/phraseHub').build();
      _hubConnection.onclose((error) => _connectionIsOpen = false);
      _hubConnection.on("SendPhrase", _onReceivePhrase);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      try {
        await _hubConnection.start();
      } catch (e) {
      }
      _connectionIsOpen = true;
    }
  }

  void _onReceivePhrase(List phrases){
    Phrase phrase = Phrase.fromJson(phrases.first[0]);
    if(phrase == null) return;
    _phrases.add(phrase);
    phrasesSink( _phrases );
  }
}
