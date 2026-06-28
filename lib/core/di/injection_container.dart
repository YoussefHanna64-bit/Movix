import 'package:movix/features/movies/data/datasources/movieDetails_remote_data_source.dart';
import 'package:movix/features/movies/data/repositories/movieDetails_repository_impl.dart';
import 'package:movix/features/movies/domain/repositories/movieDetails_repository.dart';
import 'package:movix/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movix/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movix/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movix/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:movix/features/profile/domain/repositories/profile_repository.dart';
import 'package:movix/features/profile/domain/usecases/add_to_history_usecase.dart';
import 'package:movix/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:movix/features/profile/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:movix/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import '../network/dio_client.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forget_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasource/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_action_movies_usecase.dart';
import '../../features/home/domain/usecases/get_movies_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));

  sl.registerFactory(() => AuthCubit(
        registerUseCase: sl(),
        loginUseCase: sl(),
        logoutUseCase: sl(),
        forgetPasswordUseCase: sl(),
      ));

  // Home
  sl.registerFactory(() => HomeCubit(
        getMoviesUseCase: sl(),
        getActionMoviesUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetActionMoviesUseCase(sl()));

  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioClient: sl()));

  // Movies
  sl.registerFactory(() => MoviesCubit(
        getMovieDetailsUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));

  sl.registerLazySingleton<MoviedetailsRepository>(
      () => MovieDetailsRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<MoviedetailsRemoteDataSource>(
      () => MoviedetailsRemoteDataSourceImpl(dioClient: sl()));

  // Core
  sl.registerLazySingleton(() => DioClient());

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => ToggleWishlistUseCase(sl()));
  sl.registerLazySingleton(() => AddToHistoryUseCase(sl()));

  sl.registerFactory(() => ProfileCubit(
        getUserProfileUseCase: sl(),
        updateUserProfileUseCase: sl(),
        toggleWishlistUseCase: sl(),
        addToHistoryUseCase: sl(),
      ));
}

