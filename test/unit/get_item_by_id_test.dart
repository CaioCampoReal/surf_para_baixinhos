import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';
import 'package:meu_projeto_integrador/domain/repositories/item_repository.dart';
import 'package:meu_projeto_integrador/domain/usecases/get_item_by_id.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  late GetItemById useCase;
  late MockItemRepository mockRepository;

  setUp(() {
    mockRepository = MockItemRepository();
    useCase = GetItemById(mockRepository);
  });

  const tItem = Item(
    id: '1',
    nome: 'Pneu de Alta Performance',
    preco: 299.9,
    imageUrl: 'assets/pneu.png',
    descricao: 'Pneu para carros esportivos',
    quantidade: 1,
  );

  test('deve retornar item quando encontrado pelo id', () async {
    when(() => mockRepository.getItemById('1'))
        .thenAnswer((_) async => tItem);

    final result = await useCase('1');

    expect(result, equals(tItem));
    verify(() => mockRepository.getItemById('1')).called(1);
  });
}