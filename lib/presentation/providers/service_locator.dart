import 'package:get_it/get_it.dart';
import '../../data/datasources/cart_firebase_data_source.dart';
import '../../data/datasources/item_local_data_source.dart';
import '../../data/datasources/item_local_data_source_impl.dart';
import '../../data/datasources/item_firebase_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/item_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_items.dart';
import '../../domain/usecases/get_item_by_id.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/register_with_email.dart';
import '../../domain/usecases/create_admin_user.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/add_item.dart';
import '../../domain/usecases/update_item.dart';
import '../../domain/usecases/delete_item.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../presentation/blocs/item_cubit/item_cubit.dart';
import '../../presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final GetIt sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => RegisterWithEmail(sl()));
  sl.registerLazySingleton(() => CreateAdminUser(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  sl.registerFactory(() => AuthCubit(
    signInWithEmail: sl(),
    registerWithEmail: sl(),
    createAdminUser: sl(),
    signOut: sl(),
    getCurrentUser: sl(),
  ));

  sl.registerLazySingleton<ItemFirestoreDataSource>(
    () => ItemFirestoreDataSourceImpl(), 
  );

  sl.registerLazySingleton<ItemLocalDataSource>(
    () => ItemLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(
      firestoreDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetItems(sl()));
  sl.registerLazySingleton(() => GetItemById(sl()));
  sl.registerLazySingleton(() => AddItem(sl()));
  sl.registerLazySingleton(() => UpdateItem(sl()));
  sl.registerLazySingleton(() => DeleteItem(sl()));

  sl.registerFactory(() => ItemCubit(
    getItems: sl(),
    addItemUsecase: sl(),
    updateItemUsecase: sl(),
    deleteItemUsecase: sl(),
  ));

  sl.registerLazySingleton<CartFirebaseDataSource>(
    () => CartFirebaseDataSource(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ),
  );

  sl.registerFactory(() => CartCubit(sl<CartFirebaseDataSource>()));


}