import 'package:movix/features/home/domain/usecases/get_next_page_use_case.dart';
import 'package:movix/features/movies/data/datasources/movie_details_remote_data_source.dart';
import 'package:movix/features/movies/data/repositories/movie_details_repository_impl.dart';
import 'package:movix/features/movies/domain/repositories/movie_details_repository.dart';
import 'package:movix/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movix/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movix/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:movix/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:movix/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movix/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:movix/features/profile/domain/repositories/profile_repository.dart';
import 'package:movix/features/profile/domain/usecases/add_to_history_usecase.dart';
import 'package:movix/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:movix/features/profile/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:movix/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movix/core/domain/repositories/app_state_repository.dart';
import 'package:movix/core/data/repositories/app_state_repository_impl.dart';
import 'package:movix/core/domain/usecases/check_app_state_usecase.dart';
import 'package:movix/core/domain/usecases/set_onboarding_seen_usecase.dart';
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
import '../../features/profile/domain/usecases/get_movie_by_id_usecase.dart';
import '../../features/profile/domain/usecases/get_movies_by_ids_usecase.dart';
import '../../features/home/domain/usecases/get_movies_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<AppStateRepository>(
      () => AppStateRepositoryImpl(firebaseAuth: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton(() => CheckAppStateUseCase(sl()));
  sl.registerLazySingleton(() => SetOnboardingSeenUseCase(sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  sl.registerFactory(() => AuthCubit(
        registerUseCase: sl(),
        loginUseCase: sl(),
        logoutUseCase: sl(),
        forgetPasswordUseCase: sl(),
        changePasswordUseCase: sl(),
        deleteAccountUseCase: sl(),
      ));

  // Home
  sl.registerFactory(() => HomeCubit(
        getMoviesUseCase: sl(),
        getActionMoviesUseCase: sl(),
        getNextPageUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetActionMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetNextPageUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMovieByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetMoviesByIdsUseCase(sl()));

  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioClient: sl()));

  // Movies
  sl.registerFactory(() => MoviesCubit(
        getMovieDetailsUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));

  sl.registerLazySingleton<MovieDetailsRepository>(
      () => MovieDetailsRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
      () => MovieDetailsRemoteDataSourceImpl(dioClient: sl()));

  // Core
  sl.registerLazySingleton(() => DioClient());

  sl.registerLazySingleton<ProfileRemoteDataSource>(() =>
      ProfileRemoteDataSourceImpl(
          firestore: sl(), firebaseAuth: sl(), dioClient: sl()));

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
        getMovieByIdUseCase: sl(),
        getMoviesByIdsUseCase: sl(),
      ));
}
