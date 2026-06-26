import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_action_movies_usecase.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMoviesUseCase getMoviesUseCase;
  final GetActionMoviesUseCase getActionMoviesUseCase;

  HomeCubit({
    required this.getMoviesUseCase,
    required this.getActionMoviesUseCase,
  }) : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
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
}
