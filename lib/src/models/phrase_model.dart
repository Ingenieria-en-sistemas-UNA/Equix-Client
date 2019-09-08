import 'dart:convert';

import 'package:equix/src/models/author_model.dart';
import 'package:equix/src/models/category_model.dart';


class Phrases {
  
  List<Phrase> items = new List();

  Phrases();

  Phrases.fromJsonList( List<dynamic> jsonList ) {
    if( jsonList == null ) return;

    for ( var item in jsonList ) {
      final phrase = new Phrase.fromJson( item );
      items.add( phrase );      
    }
  }
}


Phrase phraseFromJson(String str) => Phrase.fromJson(json.decode(str));

String phraseToJson(Phrase data) => json.encode(data.toJson());

class Phrase {
    int id;
    String description;
    DateTime createdAt;
    Category category;
    Author author;

    Phrase({
        this.id,
        this.description,
        this.createdAt,
        this.category,
        this.author
    });

    factory Phrase.fromJson(Map<String, dynamic> json) => new Phrase(
        id: json["id"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        category: new Category.fromJson(json["category"]),
        author: json["author"] != null ? new Author.fromJson(json["author"]) : new Author(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "createdAt": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "category": category.toJson(),
        "author": author.toJson(),
    };
}

