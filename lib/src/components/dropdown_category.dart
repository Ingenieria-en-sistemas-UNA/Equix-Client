import 'package:equix/src/blocs/category/bloc/bloc.dart';
import 'package:equix/src/models/category_model.dart';
import 'package:equix/src/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DropdownCategoriesWidget extends StatelessWidget {
  final _categoryProvider = new CategoryProvider();

  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryProvider.getCategories();
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return DropdownButton(
          hint: Text('Escoger categoria'),
          items: this._getCategoryItems(state.categories),
          onChanged: (Category value) =>
              categoryBloc.dispatch(ChangeCategory(category: value)),
          value: getCategorySelected(state.category, state.categories),
        );
      },
    );
  }

  Category getCategorySelected(Category category, List<Category> categories) {

    if(category == null) return category;

    var searchCategory;

    categories.forEach((cate){
      if(category.id == cate.id){
        searchCategory = cate;
      }
    });

    return searchCategory;
  }
  List<DropdownMenuItem<Category>> _getCategoryItems(
      List<Category> categories) {
    List<DropdownMenuItem<Category>> items = [];
    if (categories?.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('Ninguno'),
      ));
    } else {
      categories.forEach((category) {
        items.add(DropdownMenuItem(
          child: Text(category.name),
          value: category,
        ));
      });
    }
    return items;
  }
}
