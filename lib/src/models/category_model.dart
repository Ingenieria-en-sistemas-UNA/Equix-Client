import 'dart:convert';

class Categories {
  
  List<Category> items = new List();

  Categories();

  Categories.fromJsonList( List<dynamic> jsonList ) {
    if( jsonList == null ) return;

    for ( var item in jsonList ) {
      final category = new Category.fromJson( item );
      items.add( category );      
    }
  }
}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    int id;
    String name;

    Category({
        this.id,
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };

    String toString(){
      return name;
    }
}
