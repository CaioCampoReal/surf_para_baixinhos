import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item_cubit/item_cubit.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import '../providers/service_locator.dart' as di;
import '../../domain/usecases/delete_item.dart';
import 'product_form_screen.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemCubit>().loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    if (!authCubit.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Admin - Produtos')),
        body: const Center(child: Text('Acesso negado. Apenas admins.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormScreen()),
          );
          if (created == true) {
            context.read<ItemCubit>().loadItems();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemLoaded) {
            final items = state.items;
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: SizedBox(
                    width: 64,
                    child: Image.asset(item.imageUrl, fit: BoxFit.cover),
                  ),
                  title: Text(item.nome),
                  subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)} — Qtde: ${item.quantidade}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final edited = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(builder: (_) => ProductFormScreen(item: item)),
                          );
                          if (edited == true) {
                            context.read<ItemCubit>().loadItems();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (c) => AlertDialog(
                              title: const Text('Confirmar'),
                              content: Text('Excluir "${item.nome}"?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
                                TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Excluir')),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            try {
                              await di.sl<DeleteItem>().call(item.id);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produto excluído')));
                              context.read<ItemCubit>().loadItems();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao excluir: $e')));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ItemError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
