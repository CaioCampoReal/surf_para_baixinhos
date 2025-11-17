import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';
import 'package:meu_projeto_integrador/domain/usecases/get_items.dart';
import 'package:meu_projeto_integrador/domain/usecases/add_item.dart';
import 'package:meu_projeto_integrador/domain/usecases/update_item.dart';
import 'package:meu_projeto_integrador/domain/usecases/delete_item.dart';

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
  final AddItem addItemUsecase;
  final UpdateItem updateItemUsecase;
  final DeleteItem deleteItemUsecase;

  ItemCubit({
    required this.getItems,
    required this.addItemUsecase,
    required this.updateItemUsecase,
    required this.deleteItemUsecase,
  }) : super(const ItemInitial());

  Future<void> loadItems() async {
    emit(const ItemLoading());
    try {
      final items = await getItems();
      emit(ItemLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  Future<void> add(Item item) async {
    emit(const ItemLoading());
    try {
      await addItemUsecase(item);
      await loadItems();
    } catch (e) {
      emit(ItemError("Erro ao adicionar item: $e"));
    }
  }

  Future<void> update(Item item) async {
    emit(const ItemLoading());
    try {
      await updateItemUsecase(item);
      await loadItems();
    } catch (e) {
      emit(ItemError("Erro ao atualizar item: $e"));
    }
  }

  Future<void> delete(String id) async {
    emit(const ItemLoading());
    try {
      await deleteItemUsecase(id);
      await loadItems();
    } catch (e) {
      emit(ItemError("Erro ao excluir item: $e"));
    }
  }
}
