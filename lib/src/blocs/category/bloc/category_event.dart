import 'package:equix/src/models/category_model.dart';
import 'package:meta/meta.dart';

abstract class CategoryEvent {}



class LoadCategories extends CategoryEvent { }

class ChangeCategory extends CategoryEvent {
  Category category;
  ChangeCategory({ @required this.category } );
}
class ChangeCategories extends CategoryEvent {
  List<Category> categories;
  ChangeCategories({ @required this.categories });
}
