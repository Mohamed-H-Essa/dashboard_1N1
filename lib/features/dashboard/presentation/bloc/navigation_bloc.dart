import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigateToPageEvent>(_onNavigateToPage);
  }

  void _onNavigateToPage(
    NavigateToPageEvent event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.copyWith(currentPageIndex: event.pageIndex));
  }
}
