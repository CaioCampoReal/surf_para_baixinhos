import 'package:flutter_test/flutter_test.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';

void main() {
  group('Item Entity', () {
    test('deve criar Item com propriedades corretas', () {
      const item = Item(
        id: '1',
        nome: 'Pneu Teste',
        preco: 299.9,
        imageUrl: 'assets/test.png',
        descricao: 'Descrição teste',
        quantidade: 1,
      );

      expect(item.id, '1');
      expect(item.nome, 'Pneu Teste');
      expect(item.preco, 299.9);
      expect(item.imageUrl, 'assets/test.png');
      expect(item.descricao, 'Descrição teste');
      expect(item.quantidade, 1);
    });

    test('deve ser igual quando propriedades são iguais', () {
      const item1 = Item(
        id: '1',
        nome: 'Teste',
        preco: 100.0,
        imageUrl: 'test.png',
        descricao: 'Desc',
        quantidade: 1,
      );
      
      const item2 = Item(
        id: '1',
        nome: 'Teste',
        preco: 100.0,
        imageUrl: 'test.png',
        descricao: 'Desc',
        quantidade: 1,
      );

      expect(item1, equals(item2));
    });
  });
}