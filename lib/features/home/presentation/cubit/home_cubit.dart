import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/domain/usecases/get_next_page_use_case.dart';
import '../../domain/usecases/get_action_movies_usecase.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMoviesUseCase getMoviesUseCase;
  final GetActionMoviesUseCase getActionMoviesUseCase;
  final GetNextPageUseCase getNextPageUseCase;
  bool isLoadingMore = false;
  int currentPage = 1;

  HomeCubit({
    required this.getMoviesUseCase,
    required this.getActionMoviesUseCase,
    required this.getNextPageUseCase,
  }) : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      currentPage = 1;

      final results = await Future.wait([
        getMoviesUseCase.call(),
        getActionMoviesUseCase.call(),
      ]);

      final allMovies = results[0];
      final actionMovies = results[1];

      emit(HomeLoaded(
        movies: allMovies,
        actionMovies: actionMovies,
      ));
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  Future<void> loadNextPage() async {
    if (isLoadingMore) return;

    final currentState = state;
    if (currentState is! HomeLoaded) return;

    isLoadingMore = true;

    try {
      final nextMovies = await getNextPageUseCase.call(page: ++currentPage);
      emit(HomeLoaded(
        movies: [...currentState.movies, ...nextMovies],
        actionMovies: currentState.actionMovies,
        loadMoreError: null,
      ));
    } catch (e) {
      currentPage--;
      emit(HomeLoaded(
        movies: currentState.movies,
        actionMovies: currentState.actionMovies,
        loadMoreError: e.toString(),
      ));
    } finally {
      isLoadingMore = false;
    }
  }
}
