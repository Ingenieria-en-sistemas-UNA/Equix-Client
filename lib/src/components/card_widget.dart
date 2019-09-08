import 'package:flutter/material.dart';
import 'package:equix/src/models/phrase_model.dart';
import 'package:intl/intl.dart';

class CardPhraseWidget extends StatelessWidget {
  final Phrase _phrase;

  CardPhraseWidget(this._phrase);

  @override
  Widget build(BuildContext context) {
    var date = new DateFormat("dd-MM-yyyy").format(_phrase.createdAt.toUtc());
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.blue),
              title: Text(_phrase.author.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text('Dijo: ${_phrase.description}'),
                  SizedBox(height: 5.0),
                  Divider(),
                  Text('Categoria: ${_phrase.category.name}'),
                  Text('Fecha: $date'),

                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
