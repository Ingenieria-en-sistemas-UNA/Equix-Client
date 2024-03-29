import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if(s.isEmpty) return false;
  final n = num.tryParse(s);
  return ( n == null ) ? false : true;
}


void mostrarAlerta(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}