import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int currentPageIndex;

  const NavigationState({this.currentPageIndex = 0});

  NavigationState copyWith({
    int? currentPageIndex,
  }) {
    return NavigationState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }

  @override
  List<Object> get props => [currentPageIndex];
}
