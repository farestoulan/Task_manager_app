import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/data/models/categories_model/categories_model.dart';

import '../../data/repositories/categories_repository/categories_reposirory.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository categoriesRepository;
  CategoriesCubit({required this.categoriesRepository})
      : super(CategoriesInitial());

  static CategoriesCubit get(context) => BlocProvider.of(context);

//=============================== Add categories

  void addCategories({required String categoryName}) {
    try {
      emit(AddCategoriesLoading());
      categoriesRepository
          .addCategories(categoryName: categoryName)
          .then((categoriesList) {
        emit(AddCategoriesSuccess());
      }).catchError((error) {
        emit(AddCategoriesError(error: error.toString()));
      });
    } catch (e) {
      emit(AddCategoriesError(error: e.toString()));
    }
  }

//=============================== get categories
  void getCategories() {
    try {
      emit(GetCategoriesLoading());
      categoriesRepository.getCategories().then((categoriesList) {
        emit(GetCategoriesSuccess(categoriesList: categoriesList));
      }).catchError((error) {
        emit(GetCategoriesError(error: error.toString()));
      });
    } catch (e) {
      emit(GetCategoriesError(error: e.toString()));
    }
  }
//============================ delete categories

  void deletCategories({required CategoriesModel categoriesModel}) {
    try {
      emit(DeletCategoriesLoading());
      categoriesRepository
          .deletCategories(categoriesModel: categoriesModel)
          .then((categoriesList) {
        emit(DeletCategoriesSuccess());
      }).catchError((error) {
        emit(DeletCategoriesError(error: error.toString()));
      });
    } catch (e) {
      emit(DeletCategoriesError(error: e.toString()));
    }
  }
//============================== Edit categories

  void editCategories(
      {required CategoriesModel categoriesModel,
      required String categoryValueEdited}) {
    try {
      emit(EditCategoriesLoading());
      categoriesRepository
          .editCategories(
              categoriesModel: categoriesModel,
              categoryValueEdited: categoryValueEdited)
          .then((categoriesList) {
        emit(EditCategoriesSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(EditCategoriesError(error: error.toString()));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
