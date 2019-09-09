import 'package:equix/src/blocs/provider.dart';
import 'package:flutter/material.dart';
import 'package:equix/src/models/phrase_model.dart';
import 'package:intl/intl.dart';

class CardPhraseWidget extends StatelessWidget {
  final Phrase _phrase;

  CardPhraseWidget(this._phrase);

  @override
  Widget build(BuildContext context) {
    var date = new DateFormat("dd-MM-yyyy").format(_phrase.createdAt.toUtc());
    final blocUser = Provider.of(context);
    var name = _phrase.author.name == blocUser.author.name
        ? 'Yo'
        : _phrase.author.name;
    Map<int, Color> colors = {
      1 : Colors.blueAccent,
      2 : Colors.purpleAccent,
      3 : Colors.orangeAccent
    };
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
              title: Text('$name:'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(_phrase.description),
                  SizedBox(height: 5.0),
                  Divider(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(color: colors[_phrase.category.id]),
                      child: Text('${_phrase.category.name}', style: TextStyle(color: Colors.white),), 
                    ),
                    
                  ),
                  SizedBox(height: 5.0),
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
