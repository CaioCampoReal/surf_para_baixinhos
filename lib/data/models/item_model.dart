import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  final String id;
  final String nome;
  final double preco;
  final String imageUrl;
  final String descricao;
  final int quantidade;

  const ItemModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.descricao,
    required this.quantidade,
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
      quantidade: quantidade,
    );
  }

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      nome: item.nome,
      preco: item.preco,
      imageUrl: item.imageUrl,
      descricao: item.descricao,
      quantidade: item.quantidade,
    );
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'nome': nome,
      'preco': preco,
      'imageUrl': imageUrl,
      'descricao': descricao,
      'quantidade': quantidade,
    };
  }
}
