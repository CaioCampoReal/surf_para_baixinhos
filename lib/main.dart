import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'presentation/pages/home_screen.dart';
import 'presentation/providers/service_locator.dart' as di;
import 'presentation/blocs/auth_cubit/auth_cubit.dart';
import 'presentation/blocs/item_cubit/item_cubit.dart';
import 'presentation/blocs/cart_cubit/cart_cubit.dart';
import 'data/datasources/cart_firebase_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  di.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.sl<AuthCubit>(),
        ),

        BlocProvider<ItemCubit>(
          create: (context) => di.sl<ItemCubit>()..loadItems(),
        ),

        BlocProvider<CartCubit>(
          create: (_) => CartCubit(di.sl<CartFirebaseDataSource>())..loadCart(),
        ),

      ],
      child: MaterialApp(
        title: 'Surf Para Baixinhos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
