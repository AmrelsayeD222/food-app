import 'package:dio/dio.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:get_it/get_it.dart';

import '../network/services/api_service.dart';
import '../helper/shared_pref_storage.dart';

import '../../features/auth/data/repo/repo_impl.dart';
import '../../features/auth/manager/login_cubit/loign_cubit.dart';
import '../../features/auth/manager/sign_up_cubit/sign_up_cubit.dart';

import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/data/manager/cubit/home_product_cubit.dart';

import '../../features/cart/data/repo/cart_repo_impl.dart';
import '../../features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';

import '../../features/productDetalis/data/repo/product_detalis_repoimpl.dart';
import '../../features/productDetalis/data/manager/cubit/order_request_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  /// 🔹 Core
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(getIt<Dio>()),
  );

  getIt.registerLazySingleton<SharedPrefsService>(
    () => SharedPrefsService(),
  );

  /// 🔹 Repositories
  getIt.registerLazySingleton<RepoImpl>(
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

  /// 🔹 Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<RepoImpl>()),
  );

  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<RepoImpl>()),
  );

  /// Home → Singleton (عشان ميتعادش تحميل الداتا)
  getIt.registerLazySingleton<HomeProductCubit>(
    () => HomeProductCubit(getIt<HomeRepoImpl>())..fetchProduct(),
  );

  getIt.registerLazySingleton<CartCubitCubit>(
    () => CartCubitCubit(getIt<CartRepoImpl>()),
  );

  getIt.registerFactory<OrderRequestCubit>(
    () => OrderRequestCubit(getIt<ProductDetalisRepoimpl>()),
  );
  getIt.registerLazySingleton<GetProfileDataCubit>(
    () => GetProfileDataCubit(getIt<RepoImpl>()),
  );
}
