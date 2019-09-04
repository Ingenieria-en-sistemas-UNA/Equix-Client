import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:equix/src/models/phrase_model.dart';
import 'package:signalr_client/signalr_client.dart';

class PhraseProvider {
  
  PhraseProvider(){
    openConnection();
  }

  HubConnection _hubConnection;
  
  bool _connectionIsOpen = false;

  String _baseUrl = "192.168.43.102:81";

  List<Phrase> _phrases = new List();

  bool _loading = false;

  final _phrasesStreamController = StreamController<List<Phrase>>.broadcast();

  Function(List<Phrase>) get phrasesSink => _phrasesStreamController.sink.add;

  Stream<List<Phrase>> get phrasesStream => _phrasesStreamController.stream;

  void dispose() {
    _phrasesStreamController?.close();
  }

  Future<List<Phrase>> _processResponse(url) async {
    final reponse = await http.get(url);
    final decodedData = json.decode(reponse.body);
    final phrases = new Phrases.fromJsonList(decodedData);
    return phrases.items;
  }

  Future<List<Phrase>> getPhrases() async {
    if (_loading) return [];
    _loading = true;
    // final url = Uri.h(_baseUrl, 'phrases');

    final response = await _processResponse('http://$_baseUrl/api/phrases');
    _phrases = updatePhrases(response);
    phrasesSink(_phrases);
    _loading = false;
    return response;
  }

  Future<void> sendBySock() async {
    var phraseNew = new Phrase(id: 20, message: "Prueba");
    await openConnection();
    _hubConnection.invoke("SendPhrase", args: <Object>[ phraseNew.id, phraseNew.message] );
  }

  List<Phrase> updatePhrases(List<Phrase> phrasesResponse) {
    return listEquals<Phrase>(_phrases, phrasesResponse)
        ? _phrases
        : phrasesResponse;
  }

  Future<void> openConnection() async {
    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder().withUrl('http://$_baseUrl/phraseHub').build();
      _hubConnection.onclose((error) => _connectionIsOpen = false);
      _hubConnection.on("sendPhrase", _onReceivePhrase);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
      _connectionIsOpen = true;
    }
  }

  void _onReceivePhrase(phrases){
    Phrase phrase = Phrase(id: phrases.first['id'], message: phrases.first['message'] );
    if(phrase == null) return;
    _phrases.add(phrase);
    phrasesSink( _phrases );
  }
}
