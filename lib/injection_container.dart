import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:robo_app/core/network/network_info.dart';
import 'package:robo_app/features/home/data/datasources/token_remote_datasource.dart';
import 'package:robo_app/features/home/data/repositories/cocktail_repository_impl.dart';
import 'package:robo_app/features/home/data/repositories/ingredient_repository_impl.dart';
import 'package:robo_app/features/home/data/repositories/token_repository_impl.dart';
import 'package:robo_app/features/home/domain/repositories/cocktail_repository.dart';
import 'package:robo_app/features/home/domain/repositories/ingredient_repository.dart';
import 'package:robo_app/features/home/domain/repositories/token_repository.dart';
import 'package:robo_app/features/home/domain/usecases/external_login/get_data_facebook.dart';
import 'package:robo_app/features/home/domain/usecases/external_login/get_data_google.dart';
import 'package:robo_app/features/home/domain/usecases/ingredient/get_ingredient_list.dart';
import 'package:robo_app/features/home/domain/usecases/ingredient/get_ingredient_of_cocktail.dart';
import 'package:robo_app/features/home/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/ingredient/ingredient_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/services/secure_storage_service.dart';
import 'core/services/user_service.dart';
import 'features/home/data/datasources/cocktail_remote_datasource.dart';
import 'features/home/data/datasources/external_login_remote_datasouce.dart';
import 'features/home/data/datasources/ingredient_remote_datasource.dart';
import 'features/home/data/repositories/external_login_repository_impl.dart';
import 'features/home/domain/repositories/external_login_repository.dart';
import 'features/home/domain/usecases/account/access_user.dart';
import 'features/home/domain/usecases/account/get_new_token.dart';
import 'features/home/domain/usecases/cocktail/get_list_cocktail.dart';
import 'features/home/presentation/blocs/home/home_bloc.dart';
import 'features/home/presentation/blocs/initial_app/initail_app_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Log In
  sl.registerFactory(
    () => LoginBloc(
      authenticationBloc: sl(),
      userService: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthenticationBloc(
      userService: sl(),
    ),
  );
  
  sl.registerFactory(
    () => UserService(
      secureStorageServeice: sl(),
      accessUser: sl()
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => AccessUser(sl()));
  sl.registerLazySingleton(() => GetNewToken(sl()));
  sl.registerLazySingleton(() => GetDataFacebook(sl()));
  sl.registerLazySingleton(() => GetDataGoogle(sl()));

  // Repository
  sl.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ExternalLoginRepository>(
    () => ExternalLoginRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TokenRemoteDataSource>(
    () => TokenRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ExternalLoginRemoteDataSource>(
    () => ExternalLoginRemoteDataSourceImpl(),
  );

  //! Features - Home cocktail
  sl.registerFactory(
    () => HomeBloc(
      getListCocktail: sl(),
    ),
  );

  sl.registerFactory(
    () => BottomNavigationBloc(
      getListCocktail: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetListCocktail(sl()));

  // Repository
  sl.registerLazySingleton<CocktailRepository>(
    () => CocktailRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CocktailRemoteDataSource>(
    () => CocktailRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  //! Features - Ingredient Of Cocktail
  sl.registerFactory(
    () => IngredientBloc(
      getIngredientOfCocktail: sl(),
      getMasterIngredient: sl(),
    ),
  );

  //! Features - Ingredient Of Cocktail
  // Use cases
  sl.registerLazySingleton(() => GetIngredientOfCocktail(sl()));
  sl.registerLazySingleton(() => GetMasterIngredient(sl()));

  // Repository
  sl.registerLazySingleton<IngredientRepository>(
    () => IngredientRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<IngredientRemoteDataSource>(
    () => IngredientRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => SecureStorageServeice());
}
