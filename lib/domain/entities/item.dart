import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String nome;
  final double preco;
  final String imageUrl;
  final String descricao;
  final int quantidade;

  const Item({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.descricao,
    required this.quantidade,
  });

  @override
  List<Object> get props => [id, nome, preco, imageUrl, descricao, quantidade];

  Item copyWith({
    String? id,
    String? nome,
    double? preco,
    String? imageUrl,
    String? descricao,
    int? quantidade,
  }) {
    return Item(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      imageUrl: imageUrl ?? this.imageUrl,
      descricao: descricao ?? this.descricao,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}
