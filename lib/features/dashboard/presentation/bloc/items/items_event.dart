import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadItemsEvent extends ItemsEvent {
  const LoadItemsEvent();
}

class AddItemEvent extends ItemsEvent {
  const AddItemEvent();
}

class FilterItemsEvent extends ItemsEvent {
  const FilterItemsEvent();
}
