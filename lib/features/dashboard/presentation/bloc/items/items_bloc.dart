import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/item_model.dart';
import 'items_event.dart';
import 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(const ItemsInitial()) {
    on<LoadItemsEvent>(_onLoadItems);
    on<AddItemEvent>(_onAddItem);
    on<FilterItemsEvent>(_onFilterItems);
  }

  void _onLoadItems(
    LoadItemsEvent event,
    Emitter<ItemsState> emit,
  ) async {
    emit(const ItemsLoading());
    try {
      // In a real app, this would fetch data from a repository
      final items = ItemModel.getSampleItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  void _onAddItem(
    AddItemEvent event,
    Emitter<ItemsState> emit,
  ) {
    // This would add a new item in a real app
    // For now, we'll just reload the items
    add(const LoadItemsEvent());
  }

  void _onFilterItems(
    FilterItemsEvent event,
    Emitter<ItemsState> emit,
  ) {
    // This would filter items in a real app
    // For now, we'll just reload the items
    add(const LoadItemsEvent());
  }
}
