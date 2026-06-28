import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MoviesCubit({
    required this.getMovieDetailsUseCase,
  }) : super(MoviesInitial());

  Future<void> loadMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await getMovieDetailsUseCase.call(movieId);
      emit(MovieDetailsLoaded(movie: movie));
    } catch (e) {
      emit(MovieDetailsError(errorMessage: e.toString()));
    }
  }
}
