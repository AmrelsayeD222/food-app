import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';
import 'package:foods_app/features/auth/manager/Post_profile_data_cubit.dart/post_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/favourite/data/manager/fav/fav_cubit.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo.dart';
import 'package:foods_app/features/favourite/data/repo/fav_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../features/auth/data/repo/repo_impl.dart';
import '../../features/auth/manager/login_cubit/login_cubit.dart';
import '../../features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import '../../features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';
import '../../features/cart/data/repo/cart_repo_impl.dart';
import '../../features/home/data/manager/cubit/home_product_cubit.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/productDetalis/data/manager/cubit/order_request_cubit.dart';
import '../../features/productDetalis/data/repo/product_detalis_repoimpl.dart';
import '../helper/shared_pref_storage.dart';
import '../network/services/api_service.dart';

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
    () => HomeRepoImpl(getIt<ApiServices>()),
  );

  getIt.registerLazySingleton<CartRepoImpl>(
    () => CartRepoImpl(apiServices: getIt<ApiServices>()),
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
    () => FavCubit(getIt<FavRepo>())..loadFavorites(),
  );
}
