import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  final int id;
  final String nome;
  final double preco;
  final String imageUrl;
  final String descricao;

  const ItemModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.descricao,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  Item toEntity() {
    return Item(
      id: id,
      nome: nome,
      preco: preco,
      imageUrl: imageUrl,
      descricao: descricao,
    );
  }

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      nome: item.nome,
      preco: item.preco,
      imageUrl: item.imageUrl,
      descricao: item.descricao,
    );
  }
}