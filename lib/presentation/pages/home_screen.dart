import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/item.dart';
import '../blocs/item_cubit/item_cubit.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import '../blocs/auth_cubit/auth_state.dart';
import '../providers/service_locator.dart' as di;
import '../widgets/organisms/app_bar_custom.dart';
import '../widgets/organisms/image_carousel.dart';
import '../widgets/organisms/product_grid.dart';
import '../widgets/organisms/footer.dart';
import '../widgets/molecules/section_title.dart';
import '../theme/app_theme.dart';
import 'detail_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'admin_products_screen.dart';
import 'cart_screen.dart';
import '../blocs/cart_cubit/cart_cubit.dart';
import '../../domain/entities/cart_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemCubit>(
          create: (context) => di.sl<ItemCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBarCustom(
          title: 'Surf Para Baixinhos',
          backgroundColor: AppColors.primaryBlue,
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                final isClient = authState is AuthAuthenticated && !authState.user.isAdmin;
                return Row(
                  children: [
                    if (isClient)
                      IconButton(
                        icon: const Icon(Icons.shopping_cart, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CartScreen()),
                          );
                        },
                      ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onSelected: (value) {
                        _handleMenuSelection(context, value, authState);
                      },
                      itemBuilder: (BuildContext context) {
                        if (authState is AuthAuthenticated) {
                          final bool isAdmin = authState.user.isAdmin;

                          return [
                            PopupMenuItem<String>(
                              value: 'profile',
                              child: Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(authState.user.displayName),
                                      Text(
                                        authState.user.roleDisplayName,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (isAdmin) const PopupMenuDivider(),
                            if (isAdmin)
                              const PopupMenuItem<String>(
                                value: 'manage_products',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 8),
                                    Text('Gerenciar Produtos'),
                                  ],
                                ),
                              ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<String>(
                              value: 'logout',
                              child: Row(
                                children: [
                                  Icon(Icons.logout),
                                  SizedBox(width: 8),
                                  Text('Sair'),
                                ],
                              ),
                            ),
                          ];
                        } else {
                          return [
                            const PopupMenuItem<String>(
                              value: 'login',
                              child: Row(
                                children: [
                                  Icon(Icons.login),
                                  SizedBox(width: 8),
                                  Text('Entrar'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'register',
                              child: Row(
                                children: [
                                  Icon(Icons.person_add),
                                  SizedBox(width: 8),
                                  Text('Cadastrar'),
                                ],
                              ),
                            ),
                          ];
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: const _HomeScreenBody(),
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value, AuthState authState) {
    switch (value) {
      case 'login':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        break;
      case 'register':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
        break;
      case 'logout':
        context.read<AuthCubit>().logout();
        break;
      case 'profile':
        break;
      case 'manage_products':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminProductsScreen()));
        break;
    }
  }
}

class _HomeScreenBody extends StatefulWidget {
  const _HomeScreenBody();

  @override
  State<_HomeScreenBody> createState() => __HomeScreenBodyState();
}

class __HomeScreenBodyState extends State<_HomeScreenBody> {
  static const _carouselImages = [
    'assets/carrossel.png',
    'assets/carrossel2.png',
    'assets/carrossel3.png',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemCubit>().loadItems();
    });
  }

  void _navigateToDetail(BuildContext context, Item item) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is AuthAuthenticated) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: Colors.blue),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá, ${authState.user.displayName}!',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                authState.user.roleDisplayName,
                                style: TextStyle(color: Colors.blue[700], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bem-vindo ao Surf Para Baixinhos!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Faça login para uma experiência personalizada',
                                  style: TextStyle(color: Colors.orange[700], fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                            },
                            child: const Text('Entrar', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              ImageCarousel(images: _carouselImages),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Itens disponíveis', color: AppColors.primaryBlue),
              const SizedBox(height: 12),
              if (state is ItemLoading)
                _buildLoadingState(),
              if (state is ItemLoaded)
                _buildLoadedState(context, state),
              if (state is ItemError)
                _buildErrorState(context, state),
              const SizedBox(height: 40),
              const Footer(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()));

  Widget _buildLoadedState(BuildContext context, ItemLoaded state) {
    final authState = context.read<AuthCubit>().state;
    final isClient = authState is AuthAuthenticated && !authState.user.isAdmin;

    return ProductGrid(
      items: state.items,
      onItemTap: (item) => _navigateToDetail(context, item),
      onAddToCart: isClient
          ? (item) {
              final cartItem = CartItem(
                id: item.id,
                name: item.nome,
                price: item.preco,
                quantity: 1,
                imageUrl: item.imageUrl,
              );
              context.read<CartCubit>().addToCart(cartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item adicionado ao carrinho!')),
              );
            }
          : null,
    );
  }

  Widget _buildErrorState(BuildContext context, ItemError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<ItemCubit>().loadItems(),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
