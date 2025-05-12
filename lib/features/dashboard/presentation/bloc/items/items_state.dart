import 'package:equatable/equatable.dart';
import '../../../domain/models/item_model.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsInitial extends ItemsState {
  const ItemsInitial();
}

class ItemsLoading extends ItemsState {
  const ItemsLoading();
}

class ItemsLoaded extends ItemsState {
  final List<ItemModel> items;

  const ItemsLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class ItemsError extends ItemsState {
  final String message;

  const ItemsError(this.message);

  @override
  List<Object> get props => [message];
}
