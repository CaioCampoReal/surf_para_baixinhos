import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';
import 'package:meu_projeto_integrador/domain/usecases/get_items.dart';

sealed class ItemState {
  const ItemState();
}

class ItemInitial extends ItemState {
  const ItemInitial();
}

class ItemLoading extends ItemState {
  const ItemLoading();
}

class ItemLoaded extends ItemState {
  final List<Item> items;
  const ItemLoaded(this.items);
}

class ItemError extends ItemState {
  final String message;
  const ItemError(this.message);
}

class ItemCubit extends Cubit<ItemState> {
  final GetItems getItems; 
  
  ItemCubit({required this.getItems}) : super(const ItemInitial()); 

  Future<void> loadItems() async {
    emit(const ItemLoading());
    try {
      final items = await getItems(); 
      emit(ItemLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }
}