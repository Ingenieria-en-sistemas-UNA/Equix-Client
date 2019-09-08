import 'package:equix/src/models/author_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }

  set author(Author author){
    if(author != null){
      _prefs.setInt('authorId', author.id);
      _prefs.setString('authorName', author.name);
    } else {
      _prefs.remove('authorId');
      _prefs.remove('authorName');
    }
  }

  get author {
    var id = _prefs.getInt('authorId');
    var name = _prefs.getString('authorName');
    if(id != null && name != null){
      return new Author(id: id, name: name, phrases: []);
    }
    return null;
  }
  

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}
