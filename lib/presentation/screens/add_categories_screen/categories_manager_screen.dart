import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/business_logic/categories_cubit/categories_cubit.dart';
import 'package:task_manager_app/business_logic/categories_cubit/categories_state.dart';
import 'package:task_manager_app/core/app_strings/app_strings.dart';
import 'package:task_manager_app/core/reusable_component/remove_alert.dart';
import 'package:task_manager_app/core/reusable_component/toast_component.dart';
import 'package:task_manager_app/core/utils/styles/color/color_manger.dart';
import 'package:task_manager_app/data/models/categories_model/categories_model.dart';
import '../../../core/reusable_component/success_alert.dart';
import '../../widgets/categories_widgets/categries_widget.dart';
import 'package:task_manager_app/injection_container.dart' as di;

class AddCategoriesScreen extends StatefulWidget {
  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  TextEditingController categoryController = TextEditingController();

  TextEditingController editCategoryController = TextEditingController();

  List<CategoriesModel> categoriesList = [];
  @override
  void dispose() {
    categoryController.dispose();
    editCategoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) =>
          di.sl<CategoriesCubit>()..getCategories(),
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) async {
          if (state is GetCategoriesSuccess) {
            categoriesList = state.categoriesList;
          }

          if (state is AddCategoriesSuccess) {
            CategoriesCubit.get(context).getCategories();
            successAlert(
              content: AppStrings.successMassage,
              ctx: context,
              width: width,
            );
            await Future.delayed(const Duration(seconds: 1));
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            categoryController.clear();
          }
          if (state is DeletCategoriesSuccess) {
            // ignore: use_build_context_synchronously
            CategoriesCubit.get(context).getCategories();
            // ignore: use_build_context_synchronously
            showToast(
                msg: AppStrings.massageDeleted, context: context, width: width);
          }
          if (state is EditCategoriesSuccess) {
            // ignore: use_build_context_synchronously
            CategoriesCubit.get(context).getCategories();
            // ignore: use_build_context_synchronously
            showToast(
              msg: AppStrings.massageEdited,
              context: context,
              width: width,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.categoryScreenTitle,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
//==================== Row Add Categories
                  CategoriesWidgets.desginAddCategoies(
                      width: width,
                      height: height,
                      categoryController: categoryController,
                      onTapAddNew: () {
                        if (categoryController.text.isNotEmpty) {
                          CategoriesCubit.get(context).addCategories(
                              categoryName: categoryController.text);
                        } else {
                          showToast(
                              msg: AppStrings.massageValidatation,
                              context: context,
                              width: width);
                        }
                      }),
                  SizedBox(
                    height: height / 20,
                  ),
                  Divider(color: ColorManager.grey3),
                  categoriesList.isNotEmpty
//====================== Categories List
                      ? Flexible(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                CategoriesWidgets.buildItemInListCategories(
//================================ Action Edit Button
                                    onTapEdit: () {
                                      CategoriesWidgets.buildEditAlert(
                                        categoryValue:
                                            categoriesList[index].categoryName,
                                        ctx: context,
                                        height: height,
                                        width: width,
                                        doneFunction: () {
                                          Navigator.pop(context);
                                          CategoriesCubit.get(context)
                                              .editCategories(
                                                  categoryValueEdited:
                                                      editCategoryController
                                                          .text,
                                                  categoriesModel:
                                                      categoriesList[index]);
                                        },
                                        editController: editCategoryController,
                                      );
                                    },
//=================================== Action Delet Button
                                    onTapDelet: () {
                                      removeAlert(
                                          ctx: context,
                                          height: height,
                                          width: width,
                                          content: AppStrings.askRemoveCategory,
                                          doneFunction: () {
                                            Navigator.pop(context);
                                            CategoriesCubit.get(context)
                                                .deletCategories(
                                                    categoriesModel:
                                                        categoriesList[index]);
                                          });
                                    },
                                    index: index,
                                    categoriesList: categoriesList,
                                    height: height,
                                    width: width),
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemCount: categoriesList.length,
                          ),
                        )
                      : SizedBox(
                          height: height / 4,
                          child: Center(child: Text(AppStrings.noData))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
