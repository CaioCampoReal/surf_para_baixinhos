import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';
import 'package:meu_projeto_integrador/domain/repositories/item_repository.dart';
import 'package:meu_projeto_integrador/domain/usecases/get_items.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  late GetItems useCase;
  late MockItemRepository mockRepository;

  setUp(() {
    mockRepository = MockItemRepository();
    useCase = GetItems(mockRepository);
  });

  const tItems = [
    Item(
      id: 1,
      nome: 'Pneu de Alta Performance',
      preco: 299.9,
      imageUrl: 'assets/pneu.png',
      descricao: 'Pneu para carros esportivos',
    ),
  ];

  test('deve retornar lista de itens do repositório', () async {
    when(() => mockRepository.getItems()).thenAnswer((_) async => tItems);

    final result = await useCase();

    expect(result, equals(tItems));
    verify(() => mockRepository.getItems()).called(1);
  });

  test('deve propagar erro quando repositório falhar', () async {
    when(() => mockRepository.getItems()).thenThrow(Exception('Erro de rede'));

    expect(() => useCase(), throwsA(isA<Exception>()));
  });
}