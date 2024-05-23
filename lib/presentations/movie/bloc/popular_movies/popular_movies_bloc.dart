import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final MovieRepository repo;
  int _page = 1;
  PopularMoviesBloc({required this.repo}) : super(const PopularMoviesState()) {
    on<GetPopularMoviesEvent>(getPopularMovies);
  }

  Future<void> getPopularMovies(
      GetPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == PopularMovieStatus.initial) {
        final data = await repo.getPopularMovies(page: 1);

        return emit(state.copyWith(
          popularMovies: data,
          allPopularMovies: data,
          hasReachedMax: false,
          status: PopularMovieStatus.loaded,
        ));
      }
      _page = _page + 1;
      final data = await repo.getPopularMovies(page: _page);

      emit(
        data.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                allPopularMovies: List.from(state.allPopularMovies)
                  ..addAll(data),
                status: PopularMovieStatus.loaded,
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PopularMovieStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
