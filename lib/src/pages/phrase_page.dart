import 'package:equix/src/blocs/category/bloc/bloc.dart';
import 'package:equix/src/blocs/login/login_bloc.dart';
import 'package:equix/src/blocs/provider.dart';
import 'package:equix/src/components/dropdown_category.dart';
import 'package:equix/src/models/author_model.dart';
import 'package:equix/src/models/phrase_model.dart';
import 'package:equix/src/providers/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhrasePage extends StatefulWidget {
  @override
  _PhrasePageState createState() => _PhrasePageState();
}

class _PhrasePageState extends State<PhrasePage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  Phrase phrase = new Phrase(author: new Author(id: 1, name: "", phrases: []));
  bool _saving = false;

  CategoryBloc categoryBloc;

  final _phraseProvider = new PhraseProvider();

  LoginBloc blocUser;
  
  @override
  Widget build(BuildContext context) {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    blocUser = Provider.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Poster frase'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                DropdownCategoriesWidget(),
                _createDescription(),
                _createButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDescription() {
    return TextFormField(
      initialValue: phrase.description,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (String value) => phrase.description = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese la descripción de la frase';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_saving) ? null : _submit,
    );
  }

  void showSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    if(categoryBloc.category == null) return;
    phrase.category = categoryBloc.category;
    phrase.createdAt = DateTime.now();
    phrase.author = blocUser.author;
    formKey.currentState.save();

    setState(() => _saving = true);
    
    String response = await _phraseProvider.createPhrase(phrase);

    setState(() => _saving = false);

    showSnackbar(response);

    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
