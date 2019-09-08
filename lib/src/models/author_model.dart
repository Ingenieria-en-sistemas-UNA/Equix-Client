import 'dart:convert';

import 'package:equix/src/models/phrase_model.dart';

class Authors {
  
  List<Author> items = new List();

  Authors();

  Authors.fromJsonList( List<dynamic> jsonList ) {
    if( jsonList == null ) return;

    for ( var item in jsonList ) {
      final author = new Author.fromJson( item );
      items.add( author );      
    }
  }
}


Author authorFromJson(String str) => Author.fromJson(json.decode(str));

String authorToJson(Author data) => json.encode(data.toJson());

class Author {
    int id;
    String name;
    List<Phrase> phrases;

    Author({
        this.id,
        this.name,
        this.phrases,
    });

    factory Author.fromJson(Map<String, dynamic> json) => new Author(
        id      : json["id"],
        name    : json["name"],
        phrases : new List<Phrase>.from(json["phrases"].map((x) => new Phrase.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "name"    : name,
        "phrases" : new List<Phrase>.from(phrases.map((x) => x)),
    };
}