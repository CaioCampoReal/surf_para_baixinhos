import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/item.dart';
import '../../domain/usecases/add_item.dart';
import '../../domain/usecases/update_item.dart';

final sl = GetIt.instance;

class ProductFormScreen extends StatefulWidget {
  final Item? item;

  const ProductFormScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeCtrl;
  late TextEditingController precoCtrl;
  late TextEditingController imageCtrl;
  late TextEditingController descCtrl;
  late TextEditingController quantidadeCtrl;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    nomeCtrl = TextEditingController(text: widget.item?.nome ?? '');
    precoCtrl = TextEditingController(text: widget.item?.preco.toString() ?? '');
    imageCtrl = TextEditingController(text: widget.item?.imageUrl ?? '');
    descCtrl = TextEditingController(text: widget.item?.descricao ?? '');
    quantidadeCtrl = TextEditingController(text: widget.item?.quantidade.toString() ?? '0');
  }

  @override
  void dispose() {
    nomeCtrl.dispose();
    precoCtrl.dispose();
    imageCtrl.dispose();
    descCtrl.dispose();
    quantidadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final nome = nomeCtrl.text.trim();
    final preco = double.tryParse(precoCtrl.text.replaceAll(',', '.')) ?? 0.0;
    final imageUrl = imageCtrl.text.trim();
    final descricao = descCtrl.text.trim();
    final quantidade = int.tryParse(quantidadeCtrl.text) ?? 0;

    final addItemUsecase = sl<AddItem>();
    final updateItemUsecase = sl<UpdateItem>();

    try {
      if (widget.item == null) {
        final item = Item(
          id: '',
          nome: nome,
          preco: preco,
          imageUrl: imageUrl,
          descricao: descricao,
          quantidade: quantidade,
        );
        final createdId = await addItemUsecase.call(item);
        setState(() => _saving = false);
        Navigator.pop(context, true);
      } else {
        final updated = widget.item!.copyWith(
          nome: nome,
          preco: preco,
          imageUrl: imageUrl,
          descricao: descricao,
          quantidade: quantidade,
        );
        await updateItemUsecase.call(updated);
        setState(() => _saving = false);
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Adicionar Produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeCtrl,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Digite o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: precoCtrl,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Digite o preço';
                  final parsed = double.tryParse(v.replaceAll(',', '.'));
                  if (parsed == null) return 'Preço inválido';
                  if (parsed <= 0) return 'Preço deve ser maior que 0';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: quantidadeCtrl,
                decoration: const InputDecoration(labelText: 'Quantidade em estoque'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Digite a quantidade';
                  final parsed = int.tryParse(v);
                  if (parsed == null) return 'Quantidade inválida';
                  if (parsed < 0) return 'Quantidade não pode ser negativa';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: imageCtrl,
                decoration: const InputDecoration(labelText: 'URL / Asset da imagem'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Digite a imagem' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving ? const CircularProgressIndicator() : Text(isEditing ? 'Atualizar' : 'Criar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
