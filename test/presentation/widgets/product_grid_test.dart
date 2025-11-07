import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';
import 'package:meu_projeto_integrador/presentation/widgets/organisms/product_grid.dart';

void main() {
  final mockItems = [
    Item(
      id: 1,
      nome: 'Pneu Performance',
      preco: 299.9,
      imageUrl: 'assets/pneu.png',
      descricao: 'Pneu esportivo',
    ),
    Item(
      id: 2,
      nome: 'Prancha Surf',
      preco: 599.9,
      imageUrl: 'assets/prancha.png',
      descricao: 'Prancha profissional',
    ),
    Item(
      id: 3,
      nome: 'Roupa de Neoprene',
      preco: 199.9,
      imageUrl: 'assets/roupa.png',
      descricao: 'Roupa térmica',
    ),
  ];

  group('ProductGrid Widget', () {
    testWidgets('deve exibir todos os itens do grid', (WidgetTester tester) async {
      var tappedItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(
              items: mockItems,
              onItemTap: (item) => tappedItem = item,
            ),
          ),
        ),
      );

      expect(find.text('Pneu Performance'), findsOneWidget);
      expect(find.text('Prancha Surf'), findsOneWidget);
      expect(find.text('Roupa de Neoprene'), findsOneWidget);
      expect(find.text('R\$ 299.90'), findsOneWidget);
      expect(find.text('R\$ 599.90'), findsOneWidget);
      expect(find.text('R\$ 199.90'), findsOneWidget);
    });

    testWidgets('deve chamar onItemTap quando item for pressionado', (WidgetTester tester) async {
      var tappedItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(
              items: mockItems,
              onItemTap: (item) => tappedItem = item,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Pneu Performance'));
      await tester.pump();

      expect(tappedItem, isNotNull);
      expect(tappedItem.id, 1);
      expect(tappedItem.nome, 'Pneu Performance');
    });

    testWidgets('deve exibir imagem dos produtos', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(
              items: mockItems,
              onItemTap: (item) {},
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsNWidgets(mockItems.length));
    });

    testWidgets('deve exibir grid vazio quando não houver itens', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(
              items: [],
              onItemTap: (item) {},
            ),
          ),
        ),
      );

      expect(find.text('Pneu Performance'), findsNothing);
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
