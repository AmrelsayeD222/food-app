import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';
import 'package:foods_app/features/auth/manager/Post_profile_data_cubit.dart/post_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/cart/data/manager/removeCart/remove_cubit.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:foods_app/features/auth/data/repo/repo_impl.dart';
import 'package:foods_app/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:foods_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:foods_app/features/cart/data/manager/getCartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/data/repo/home_repo_impl.dart';
import 'package:foods_app/features/productDetalis/data/manager/cubit/order_request_cubit.dart';
import 'package:foods_app/features/productDetalis/data/repo/product_detalis_repoimpl.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/core/network/services/api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  /// 🔹 Core
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
    return dio;
  });

  getIt.registerLazySingleton<SharedPrefsService>(
    () => SharedPrefsService(),
  );

  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(getIt<Dio>(), getIt<SharedPrefsService>()),
  );

  /// 🔹 Repositories
  getIt.registerLazySingleton<Repo>(
    () => RepoImpl(
      getIt<ApiServices>(),
      getIt<SharedPrefsService>(),
    ),
  );

  getIt.registerLazySingleton<HomeRepoImpl>(
    () => HomeRepoImpl(
      getIt<ApiServices>(),
      getIt<SharedPrefsService>(),
    ),
  );

  getIt.registerLazySingleton<CartRepoImpl>(
    () => CartRepoImpl(
      apiServices: getIt<ApiServices>(),
      sharedPrefsService: getIt<SharedPrefsService>(),
    ),
  );

  getIt.registerLazySingleton<ProductDetalisRepoimpl>(
    () => ProductDetalisRepoimpl(getIt<ApiServices>()),
  );

  getIt.registerLazySingleton<FavRepo>(
    () => FavRepoImpl(apiServices: getIt<ApiServices>()),
  );

  /// 🔹 Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<Repo>()),
  );

  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<Repo>()),
  );
  getIt.registerLazySingleton<HomeProductCubit>(
    () => HomeProductCubit(getIt<HomeRepoImpl>())..fetchProduct(),
  );

  getIt.registerLazySingleton<CartCubitCubit>(
    () => CartCubitCubit(getIt<CartRepoImpl>(), getIt<SharedPrefsService>()),
  );

  getIt.registerLazySingleton<RemoveCubit>(
    () => RemoveCubit(getIt<CartRepoImpl>()),
  );

  getIt.registerFactory<OrderRequestCubit>(
    () => OrderRequestCubit(getIt<ProductDetalisRepoimpl>()),
  );
  getIt.registerLazySingleton<GetProfileDataCubit>(
    () => GetProfileDataCubit(getIt<Repo>(), getIt<SharedPrefsService>()),
  );
  getIt.registerFactory<PostProfileDataCubit>(
    () => PostProfileDataCubit(getIt<Repo>()),
  );

  getIt.registerLazySingleton<FavCubit>(
    () => FavCubit(getIt<FavRepo>(), getIt<SharedPrefsService>())
      ..loadFavorites(),
  );
}
