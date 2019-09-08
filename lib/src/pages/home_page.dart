import 'package:equix/src/blocs/category/bloc/bloc.dart';
import 'package:equix/src/blocs/provider.dart';
import 'package:equix/src/components/card_widget.dart';
import 'package:equix/src/components/dropdown_category.dart';
import 'package:equix/src/models/author_model.dart';
import 'package:equix/src/models/phrase_model.dart';
import 'package:equix/src/preferencias_usuario/PreferenciasUsuario.dart';
import 'package:equix/src/providers/category_provider.dart';
import 'package:flutter/material.dart';

import 'package:equix/src/providers/phrase_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _phraseProvider = new PhraseProvider();
  final prefs = new PreferenciasUsuario();
  CategoryBloc categoryBloc;
  @override
  Widget build(BuildContext context) {
    _phraseProvider.getPhrases();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.dispatch(LoadCategories());
    final blocUser = Provider.of(context);

    var author = prefs.author;
    blocUser.changeAuthor(author); 

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(blocUser.author.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              prefs.token = '';
              prefs.author = null;
              blocUser.changeAuthor(null);
              blocUser.changeEmail('');
              blocUser.changePassword('');
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _phraseProvider.phrasesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Phrase>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final phrase = snapshot.data[index];
                return Container(
                  margin: EdgeInsets.all(5.0),
                  child: CardPhraseWidget(phrase),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'phrase'),
      ),
    );
  }

}
