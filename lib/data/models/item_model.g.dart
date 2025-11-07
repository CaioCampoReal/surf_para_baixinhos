// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: (json['id'] as num).toInt(),
      nome: json['nome'] as String,
      preco: (json['preco'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      descricao: json['descricao'] as String,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'preco': instance.preco,
      'imageUrl': instance.imageUrl,
      'descricao': instance.descricao,
    };
