abstract class SearchEvent {}

class SearchTextTaskNameChangedEvent extends SearchEvent {
  final String searchedTextTaskNameChanged;

  SearchTextTaskNameChangedEvent({required this.searchedTextTaskNameChanged});
}
