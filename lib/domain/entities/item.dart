import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String nome;
  final double preco;
  final String imageUrl;
  final String descricao;

  const Item({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.descricao,
  });

  @override
  List<Object> get props => [id, nome, preco, imageUrl, descricao];

  Item copyWith({
    int? id,
    String? nome,
    double? preco,
    String? imageUrl,
    String? descricao,
  }) {
    return Item(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      imageUrl: imageUrl ?? this.imageUrl,
      descricao: descricao ?? this.descricao,
    );
  }
}