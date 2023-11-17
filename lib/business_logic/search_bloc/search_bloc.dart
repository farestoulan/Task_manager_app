import 'package:bloc/bloc.dart';
import 'package:task_manager_app/business_logic/search_bloc/search_event.dart';
import 'package:task_manager_app/business_logic/search_bloc/search_state.dart';

import '../../data/repositories/search_repository/search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      if (event is SearchTextTaskNameChangedEvent) {
        try {
          emit(SearchTextTaskNameChangedLoadingState());

          searchRepository
              .getTasks(
                  searchedTextTaskNameChanged:
                      event.searchedTextTaskNameChanged)
              .then((searchedTasksList) {
            emit(SearchTextTaskNameChangedSuccessState(
                searchedTasksList: searchedTasksList));
          });
        } catch (e) {
          emit(GetTasksSearchedError(error: e.toString()));
        }
      }
    }, transformer: (events, mapper) {
      print('test fares11');
      return events
          .debounceTime(const Duration(milliseconds: 250))
          .asyncExpand(mapper);
    });
  }
}
