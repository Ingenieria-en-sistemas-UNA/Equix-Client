import 'dart:convert';


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


// Phrase phraseFromJson(String str) => Phrase.fromJson(json.decode(str));

// String phraseToJson(Phrase data) => json.encode(data.toJson());

class Phrase {
  int id;
  String message;

  Phrase({
    this.id,
    this.message,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) => new Phrase(
        id      : json["id"],
        message : json["message"],
      );

  Map<String, dynamic> toJson() => {
    "id"      : id,
    "message" : message,
  };
}
