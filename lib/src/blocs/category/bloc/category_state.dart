import 'package:equix/src/models/category_model.dart';

class CategoryState {
  Category category;
  List<Category> categories;

  CategoryState._internal({this.category, this.categories});

  CategoryState();

  CategoryState copyWith({Category category, List<Category> categories}) {
    return CategoryState._internal(
        category: category ?? this.category,
        categories: categories ?? this.categories);
  }
}
