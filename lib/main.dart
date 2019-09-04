import 'package:equix/src/providers/phrase_provider.dart';
import 'package:flutter/material.dart';

import 'src/models/phrase_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _phraseProvider = new PhraseProvider();

  @override
  Widget build(BuildContext context) {
    _phraseProvider.getPhrases();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equix',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Equix'),
        ),
        body: StreamBuilder(
          stream: _phraseProvider.phrasesStream,
          builder: (BuildContext context, AsyncSnapshot<List<Phrase>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final phrase = snapshot.data[index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(phrase.message),
                      ),
                      Divider()
                    ],
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon( Icons.add ),
          onPressed: () => _phraseProvider.sendBySock(),
        ),
      ),
    );
  }
}
