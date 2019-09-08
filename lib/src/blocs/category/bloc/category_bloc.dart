import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equix/src/models/category_model.dart';
import 'package:equix/src/providers/category_provider.dart';
import './bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryProvider categoryProvider = new CategoryProvider();

  @override
  CategoryState get initialState => CategoryState();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is LoadCategories) {
      await _mapCategoriesToState();
    }
    if (event is ChangeCategory) {
      yield currentState.copyWith(category: event.category);
    }
    if (event is ChangeCategories) {
      yield currentState.copyWith(categories: event.categories);
    }
  }

  Category get category => currentState.category;
  List<Category> get categories => currentState.categories;

  _mapCategoriesToState() async {
    final categories = await this.categoryProvider.getCategories();
    this.dispatch(ChangeCategories(categories: categories));
  }
}
